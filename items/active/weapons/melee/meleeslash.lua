-- Melee primary ability
MeleeSlash = WeaponAbility:new()

function MeleeSlash:init()
  self.damageConfig.baseDamage = self.baseDps * self.fireTime

  self.energyUsage = self.energyUsage or 0

  self.weapon:setStance(self.stances.idle)

  self.cooldownTimer = self:cooldownTime()

  self.weapon.onLeaveAbility = function()
    self.weapon:setStance(self.stances.idle)
  end
      
end

-- Ticks on every update regardless if this is the active ability
function MeleeSlash:update(dt, fireMode, shiftHeld)
  WeaponAbility.update(self, dt, fireMode, shiftHeld)

  self.cooldownTimer = math.max(0, self.cooldownTimer - self.dt)

  if not self.weapon.currentAbility and self.fireMode == (self.activatingFireMode or self.abilitySlot) and self.cooldownTimer == 0 and (self.energyUsage == 0 or not status.resourceLocked("energy")) then
    self:setState(self.windup)
  end
  
end

-- State: windup
function MeleeSlash:windup()
  self.weapon:setStance(self.stances.windup)

  if self.stances.windup.hold then
    while self.fireMode == (self.activatingFireMode or self.abilitySlot) do
      coroutine.yield()
    end
  else
    util.wait(self.stances.windup.duration)
  end

  if self.energyUsage then
    status.overConsumeResource("energy", self.energyUsage)
  end

  if self.stances.preslash then
    self:setState(self.preslash)
  else
    self:setState(self.fire)
  end
end

-- State: preslash
-- brief frame in between windup and fire
function MeleeSlash:preslash()
  self.weapon:setStance(self.stances.preslash)
  self.weapon:updateAim()

  util.wait(self.stances.preslash.duration)
  --*************************************    
  -- FU/FR ADDONS
   if self.blockCount == nil then 
     self.blockCount = 4
   end
            if world.entitySpecies(activeItem.ownerEntityId()) == "hylotl" then
              self.blockCount = self.blockCount + 0.18
              status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
            end     
            if world.entitySpecies(activeItem.ownerEntityId()) == "hylotl" then
              self.blockCount = self.blockCount + 3
              status.setPersistentEffects("hylotlbonusdmg", {{stat = "protection", amount = self.blockCount}})  
            end                
--************************************** 
  self:setState(self.fire)
end

-- State: fire
function MeleeSlash:fire()
  self.weapon:setStance(self.stances.fire)
  self.weapon:updateAim()
  --*************************************    
  -- FU/FR ADDONS
   if self.blockCount == nil then 
     self.blockCount = 4 
   end
   
          if world.entitySpecies(activeItem.ownerEntityId()) == "wasphive" then      --daggers do 25% more damage
		local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isDagger(heldItem) then
                          self.blockCount = self.blockCount + 0.25
                          status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isDagger(heldItem) then
                          self.blockCount = self.blockCount + 0.25
                          status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end
		end
          end  
          
          
            if world.entitySpecies(activeItem.ownerEntityId()) == "hylotl" then  --hylotl get protection when swinging their weapon
              self.blockCount = self.blockCount + 3
              status.setPersistentEffects("hylotlbonusdmg", {{stat = "protection", amount = self.blockCount}})  
            end   
--************************************** 
  animator.setAnimationState("swoosh", "fire")
  animator.playSound(self.fireSound or "fire")
  animator.burstParticleEmitter((self.elementalType or self.weapon.elementalType) .. "swoosh")

  util.wait(self.stances.fire.duration, function()
    local damageArea = partDamageArea("swoosh")
    self.weapon:setDamage(self.damageConfig, damageArea, self.fireTime)
  end)

  self.cooldownTimer = self:cooldownTime()
          
end

function MeleeSlash:cooldownTime()
  return self.fireTime - self.stances.windup.duration - self.stances.fire.duration

end



-- ****************************************************************
-- FrackinRaces weapon specialization
-- ****************************************************************
--function isHoldingDagger() --check both hands for weapons
--	local heldItem = world.entityHandItem(entity.id(), "primary")
--	if heldItem ~= nil then
--		if isDagger(heldItem) then
--			self.currentWeaponWeight = getWeaponDrain(heldItem)or 0.5
--			return true
--		end
--	end
--	heldItem = world.entityHandItem(entity.id(), "alt")
--	if heldItem ~= nil then
--		if isDagger(heldItem) then
--			self.currentWeaponWeight = getWeaponDrain(heldItem) or 0.5
--			return true
--		end
--	end
--	return false
--end
function isDagger(name)
	if root.itemHasTag(name, "dagger") then
		return true
	end
	return false
end


function isSpear(name)
	if root.itemHasTag(name, "spear") then
		return true
	end
	return false
end

function isShortsword(name)
	if root.itemHasTag(name, "shortsword") then
		return true
	end
	return false
end


function isAxe(name)
	if root.itemHasTag(name, "axe") then
		return true
	end
	return false
end


function isHammer(name)
	if root.itemHasTag(name, "hammer") then
		return true
	end
	return false
end

function isBroadsword(name)
	if root.itemHasTag(name, "broadsword") then
		return true
	end
	return false
end

function isFist(name)
	if root.itemHasTag(name, "fist") then
		return true
	end
	return false
end

function isWhip(name)
	if root.itemHasTag(name, "whip") then
		return true
	end
	return false
end

function isChakram(name)
	if root.itemHasTag(name, "chakram") then
		return true
	end
	return false
end

function isBoomerang(name)
	if root.itemHasTag(name, "chakram") then
		return true
	end
	return false
end

-- ***********************************************************************************************
-- END specialization
-- ***********************************************************************************************



function MeleeSlash:uninit()
  self.weapon:setDamage()
  status.clearPersistentEffects("hylotlbonusdmg")
  self.blockCount = 0
end



