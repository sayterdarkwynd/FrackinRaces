require "/scripts/util.lua"
require "/scripts/status.lua"

function init()
  self.debug = false

  if self.debug then sb.logInfo("(FR) shield.lua init() for %s", activeItem.hand()) end

  self.aimAngle = 0
  self.aimDirection = 1

  self.active = false
  self.cooldownTimer = config.getParameter("cooldownTime")
  self.activeTimer = 0

  self.level = config.getParameter("level", 1)
  self.baseShieldHealth = config.getParameter("baseShieldHealth", 1)
  self.knockback = config.getParameter("knockback", 0)
  self.perfectBlockDirectives = config.getParameter("perfectBlockDirectives", "")
  self.perfectBlockTime = config.getParameter("perfectBlockTime", 0.2)
  self.minActiveTime = config.getParameter("minActiveTime", 0)
  self.cooldownTime = config.getParameter("cooldownTime")
  self.forceWalk = config.getParameter("forceWalk", false)

  animator.setGlobalTag("directives", "")
  animator.setAnimationState("shield", "idle")
  activeItem.setOutsideOfHand(true)

  self.stances = config.getParameter("stances")
  setStance(self.stances.idle)
  
  self.blockCount = 0.01
  self.ownerRace = world.entitySpecies(activeItem.ownerEntityId())

  
  self.startHealth = status.resource("health")
  

            if self.ownerRace == "glitch" then
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isShield(heldItem) then
              			self.blockCount = 1
              			status.setPersistentEffects("shieldBonus", {{stat = "protection", amount = self.blockCount}})    	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if  isShield(heldItem) then
              			self.blockCount = 1
              			status.setPersistentEffects("shieldBonus", {{stat = "protection", amount = self.blockCount}})   	
			end
		end  
            end   
            
  updateAim()
end


-- ****************************************************************
-- FrackinRaces weapon specialization
-- ****************************************************************
function isShield(name)
	if root.itemHasTag(name, "shield") then
		return true
	end
	return false
end


function update(dt, fireMode, shiftHeld)            
  self.cooldownTimer = math.max(0, self.cooldownTimer - dt)

--**************************************
 if self.blockCount == nil then 
   self.blockCount = 0.01 
 end
--**************************************

  if not self.active
    and fireMode == "primary"
    and self.cooldownTimer == 0
    and status.resourcePositive("shieldStamina") then
    raiseShield()
  end

  if self.active then
    self.activeTimer = self.activeTimer + dt

    self.damageListener:update()

    if status.resourcePositive("perfectBlock") then
      animator.setGlobalTag("directives", self.perfectBlockDirectives)
    else
      animator.setGlobalTag("directives", "")
    end

    if self.forceWalk then
      mcontroller.controlModifiers({runningSuppressed = true})
    end

    if (fireMode ~= "primary" and self.activeTimer >= self.minActiveTime) or not status.resourcePositive("shieldStamina") then
      lowerShield()
    end
  elseif self.damageListener and self.damageListener.update then
    self.damageListener:update()
  end

  updateAim()
end

function uninit()
  status.clearPersistentEffects(activeItem.hand().."Shield")
  activeItem.setItemShieldPolys({})
  activeItem.setItemDamageSources({})
  status.clearPersistentEffects("humanprotection")
  status.clearPersistentEffects("ningenprotection")
  status.clearPersistentEffects("vieraprotection")
  status.clearPersistentEffects("hylotlprotection")
  status.clearPersistentEffects("glitchprotection")
  status.clearPersistentEffects("shieldBonus") 
end

function updateAim()
  local aimAngle, aimDirection = activeItem.aimAngleAndDirection(0, activeItem.ownerAimPosition())
  
  if self.stance.allowRotate then
    self.aimAngle = aimAngle
  end
  activeItem.setArmAngle(self.aimAngle + self.relativeArmRotation)

  if self.stance.allowFlip then
    self.aimDirection = aimDirection
  end
  activeItem.setFacingDirection(self.aimDirection)

  animator.setGlobalTag("hand", isNearHand() and "near" or "far")
  activeItem.setOutsideOfHand(not self.active or isNearHand())
end

function isNearHand()
  return (activeItem.hand() == "primary") == (self.aimDirection < 0)
end

function setStance(stance)
  self.stance = stance
  self.relativeShieldRotation = util.toRadians(stance.shieldRotation) or 0
  self.relativeArmRotation = util.toRadians(stance.armRotation) or 0
end

function raiseShield()
  setStance(self.stances.raised)
  animator.setAnimationState("shield", "raised")
  animator.playSound("raiseShield")
  self.active = true
  self.activeTimer = 0
  status.setPersistentEffects(activeItem.hand().."Shield", {{stat = "shieldHealth", amount = shieldHealth()}})
  local shieldPoly = animator.partPoly("shield", "shieldPoly")
  activeItem.setItemShieldPolys({shieldPoly})

  if self.knockback > 0 then
    local knockbackDamageSource = {
      poly = shieldPoly,
      damage = 0,
      damageType = "Knockback",
      sourceEntity = activeItem.ownerEntityId(),
      team = activeItem.ownerTeam(),
      knockback = self.knockback,
      rayCheck = true,
      damageRepeatTimeout = 0.25
    }
    activeItem.setItemDamageSources({ knockbackDamageSource })
  end

  self.damageListener = damageListener("damageTaken", function(notifications)
    for _,notification in pairs(notifications) do
	  self.ownerRace = world.entitySpecies(activeItem.ownerEntityId()) or sb.logInfo("(FR) shield.lua:update() DANGER! Race is nil!")
	  if notification.hitType == "ShieldHit" then
        if status.resourcePositive("perfectBlock") then
          animator.playSound("perfectBlock")
          animator.burstParticleEmitter("perfectBlock")

          -- *******************************************************
          self.blockCount = self.blockCount + 0.01
          -- *******************************************************
          -- FRACKIN UNIVERSE and FRACKIN RACES abilities start here
          -- *******************************************************
          -- *******************************************************
          -- *******************************************************

          if self.ownerRace == "glitch" then
            self.blockCount = self.blockCount + 0.03
            status.setPersistentEffects("glitchprotection", {{stat = "powerMultiplier", amount = self.blockCount}})  --glitch get a power bonus when perfectly blocking
            animator.burstParticleEmitter("bonusBlock3")
            animator.playSound("bonusEffect")
          end
	  if self.ownerRace == "hylotl" then
            status.modifyResourcePercentage("health", 0.05 + self.blockCount )  --hylotl get a heal when they perfectly block
            animator.burstParticleEmitter("bonusBlock")
            animator.playSound("bonusEffect")
          end
	  if self.ownerRace == "viera" then
            status.modifyResourcePercentage("energy", 0.07 + self.blockCount )  --viera get energy when they perfectly block
            animator.burstParticleEmitter("bonusBlock2")
            animator.playSound("bonusEffect")
          end
	  if self.ownerRace == "human" then
            self.blockCount = self.blockCount + 2
            status.setPersistentEffects("humanprotection", {{stat = "protection", amount = self.blockCount}})  --human get a defense bonus when perfectly blocking
            animator.burstParticleEmitter("bonusBlock4")
            animator.playSound("bonusEffect")
          end
          if self.ownerRace == "ningen" then
            self.blockCount = self.blockCount + 2
            status.setPersistentEffects("ningenprotection", {{stat = "protection", amount = self.blockCount}})  --human get a defense bonus when perfectly blocking
            animator.burstParticleEmitter("bonusBlock4")
            animator.playSound("bonusEffect")
          end          
		  if self.debug then sb.logInfo("(FR) shield.lua: Perfect block! blockCount now %s",self.blockCount) end
          -- *******************************************************
          -- *******************************************************
          -- *******************************************************
          -- *******************************************************
          
          refreshPerfectBlock()
        elseif status.resourcePositive("shieldStamina") then
          animator.playSound("block")
          
          -- *******************************************************
		  if self.debug then sb.logInfo("(FR) shield.lua: hitType %s received, blockCount = %s, blockCount reset",notification.hitType, self.blockCount) end
		  clearEffects(self.ownerRace)
          -- *******************************************************    
          
        else
          animator.playSound("break")

          -- *******************************************************
		  if self.debug then sb.logInfo("(FR) shield.lua: hitType %s received, blockCount = %s, blockCount reset",notification.hitType, self.blockCount) end
		  clearEffects(self.ownerRace)
          -- *******************************************************
          
        end
        animator.setAnimationState("shield", "block")
        return
	  else
		if self.debug then sb.logInfo("(FR) shield.lua: non-ShieldHit: %s", notification.hitType) end
		-- hit is required to do damage, else collisions with, e.g., rain could trigger the reset
		if self.blockCount > 0.01 and notification.healthLost --[[.damageDealt?]] > 0 then
		  if self.debug then sb.logInfo("(FR) shield.lua: hitType %s received, blockCount = %s, blockCount reset",notification.hitType, self.blockCount) end
		  clearEffects(self.ownerRace)
		end
      end
    end
  end)

  refreshPerfectBlock()
end

function clearEffects(playerRace)
  status.clearPersistentEffects(playerRace .. "protection")
  self.blockCount = 0.01
end

function refreshPerfectBlock()
  local perfectBlockTimeAdded = math.max(0, math.min(status.resource("perfectBlockLimit"), self.perfectBlockTime - status.resource("perfectBlock")))
  status.overConsumeResource("perfectBlockLimit", perfectBlockTimeAdded)
  status.modifyResource("perfectBlock", perfectBlockTimeAdded)
end

function lowerShield()
  setStance(self.stances.idle)
  animator.setGlobalTag("directives", "")
  animator.setAnimationState("shield", "idle")
  animator.playSound("lowerShield")
  self.active = false
  self.activeTimer = 0
  status.clearPersistentEffects(activeItem.hand().."Shield")
  activeItem.setItemShieldPolys({})
  activeItem.setItemDamageSources({})
  self.cooldownTimer = self.cooldownTime
end

function shieldHealth()
  return self.baseShieldHealth * root.evalFunction("shieldLevelMultiplier", self.level)
end
