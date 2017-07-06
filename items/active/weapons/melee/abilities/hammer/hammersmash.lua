require "/scripts/util.lua"
require "/scripts/poly.lua"
require "/scripts/interp.lua"
require "/items/active/weapons/melee/meleeslash.lua"

-- Hammer primary attack
-- Extends default melee attack and overrides windup and fire
HammerSmash = MeleeSlash:new()
function HammerSmash:init()
  self.stances.windup.duration = self.fireTime - self.stances.preslash.duration - self.stances.fire.duration

  MeleeSlash.init(self)
  self:setupInterpolation()
  local bounds = mcontroller.boundBox()
end

function HammerSmash:windup(windupProgress)
  self.weapon:setStance(self.stances.windup)
--*************************************    
-- FU/FR ADDONS

--**************************************  

  local windupProgress = windupProgress or 0
  local bounceProgress = 0
  while self.fireMode == "primary" and (self.allowHold ~= false or windupProgress < 1) do
    if windupProgress < 1 then
    
      windupProgress = math.min(1, windupProgress + (self.dt / self.stances.windup.duration))
      self.weapon.relativeWeaponRotation, self.weapon.relativeArmRotation = self:windupAngle(windupProgress)
    else
      bounceProgress = math.min(1, bounceProgress + (self.dt / self.stances.windup.bounceTime))
      self.weapon.relativeWeaponRotation, self.weapon.relativeArmRotation = self:bounceWeaponAngle(bounceProgress)
      
--**************************************        

--************************************** 

    end
    coroutine.yield()
  end

  if windupProgress >= 1.0 then
    if self.stances.preslash then
      self:setState(self.preslash)
    else
      self:setState(self.fire)     
    end
  else
    self:setState(self.winddown, windupProgress)
  end
end

function HammerSmash:winddown(windupProgress)
  self.weapon:setStance(self.stances.windup)
  while windupProgress > 0 do
    if self.fireMode == "primary" then
      self:setState(self.windup, windupProgress)
      return true
    end

    windupProgress = math.max(0, windupProgress - (self.dt / self.stances.windup.duration))
    self.weapon.relativeWeaponRotation, self.weapon.relativeArmRotation = self:windupAngle(windupProgress)
    coroutine.yield()
  end
end

function HammerSmash:fire()
  self.weapon:setStance(self.stances.fire)
  self.weapon:updateAim()

  animator.setAnimationState("swoosh", "fire")
  animator.playSound("fire")
  animator.burstParticleEmitter(self.weapon.elementalType .. "swoosh")

  local smashMomentum = self.smashMomentum
  smashMomentum[1] = smashMomentum[1] * mcontroller.facingDirection()
  mcontroller.addMomentum(smashMomentum)


-- ******************* FR ADDONS FOR HAMMER SWINGS
  if status.isResource("food") then
      self.foodValue = status.resource("food")
      hungerLevel = status.resource("food")
  else
      self.foodValue = 50
      hungerLevel = 50
  end
    --food defaults
    hungerMax = { pcall(status.resourceMax, "food") }
    hungerMax = hungerMax[1] and hungerMax[2]
	if status.isResource("energy") then
	  self.energyValue = status.resource("energy")  --check our Food level
	else
	  self.energyValue = 80
	end	

     local species = world.entitySpecies(activeItem.ownerEntityId())
     -- Primary hand, or single-hand equip  
     local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
     --used for checking dual-wield setups
     local opposedhandHeldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand() == "primary" and "alt" or "primary")
     local randValue = math.random(100)  -- chance for projectile       
     if not self.meleeCount then self.meleeCount = 0 end
     
	if species == "floran" then  --florans use food when attacking
	  if status.isResource("food") then
	   status.modifyResource("food", (status.resource("food") * -0.01) )
	  end
	end
	
	if species == "glitch" and heldItem then  --glitch consume energy when wielding axes and hammers. They get increased critChance as a result
	  if root.itemHasTag(heldItem, "greataxe") then
		  if not self.critValueGlitch then self.critValueGlitch = ( math.ceil(self.energyValue/16) ) end  
		  if self.energyValue >= 25 then
		    if status.isResource("food") then
			     adjustedHunger = hungerLevel - (hungerLevel * 0.01)
			     status.setResource("food", adjustedHunger)	      
		    end	 	       
		    status.setPersistentEffects("glitchEnergyPower", {
			{ stat = "critChance", amount = self.critValueGlitch }
		      }) 	    
		  end
	  end
	end  	
-- ***********************************************	

  local smashTimer = self.stances.fire.smashTimer
  local duration = self.stances.fire.duration
  while smashTimer > 0 or duration > 0 do
    smashTimer = math.max(0, smashTimer - self.dt)
    duration = math.max(0, duration - self.dt)

    local damageArea = partDamageArea("swoosh")
    if not damageArea and smashTimer > 0 then
      damageArea = partDamageArea("blade")
    end
    self.weapon:setDamage(self.damageConfig, damageArea, self.fireTime)

    if smashTimer > 0 then
      local groundImpact = world.polyCollision(poly.translate(poly.handPosition(animator.partPoly("blade", "groundImpactPoly")), mcontroller.position()))
      if mcontroller.onGround() or groundImpact then
        smashTimer = 0
        if groundImpact then
          animator.burstParticleEmitter("groundImpact")
          animator.playSound("groundImpact")
        end
      end
    end
    coroutine.yield()
  end

  self.cooldownTimer = self:cooldownTime()
end

function HammerSmash:setupInterpolation()
  for i, v in ipairs(self.stances.windup.bounceWeaponAngle) do
    v[2] = interp[v[2]]
  end
  for i, v in ipairs(self.stances.windup.bounceArmAngle) do
    v[2] = interp[v[2]]
  end
  for i, v in ipairs(self.stances.windup.weaponAngle) do
    v[2] = interp[v[2]]
  end
  for i, v in ipairs(self.stances.windup.armAngle) do
    v[2] = interp[v[2]]
  end
end

function HammerSmash:bounceWeaponAngle(ratio)
  local weaponAngle = interp.ranges(ratio, self.stances.windup.bounceWeaponAngle)
  local armAngle = interp.ranges(ratio, self.stances.windup.bounceArmAngle)

  return util.toRadians(weaponAngle), util.toRadians(armAngle)
end

function HammerSmash:windupAngle(ratio)
  local weaponRotation = interp.ranges(ratio, self.stances.windup.weaponAngle)
  local armRotation = interp.ranges(ratio, self.stances.windup.armAngle)

  return util.toRadians(weaponRotation), util.toRadians(armRotation)
end


function HammerSmash:uninit()
  status.clearPersistentEffects("glitchEnergyPower")
  status.clearPersistentEffects("floranFoodPowerBonus")
  status.clearPersistentEffects("apexbonusdmg")
  self.blockCount = 0
end
