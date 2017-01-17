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


local species = world.entitySpecies(activeItem.ownerEntityId())


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

      -- *********************************
      -- FR RACIAL BONUSES FOR WEAPONS   --- Bonus effect when winding up weapon
      -- *********************************
   --if self.meleeCount == nil then 
   --  self.meleeCountslash = 0
   --end       

    --**************************************             
    --**************************************           
          
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
  self:setState(self.fire)
end

-- State: fire
function MeleeSlash:fire()
     
  self.weapon:setStance(self.stances.fire)
  self.weapon:updateAim()

      -- ******************************************************************************************************************
      -- FR RACIAL BONUSES FOR WEAPONS   --- Bonus effect when attacking 
      -- ******************************************************************************************************************
     local species = world.entitySpecies(activeItem.ownerEntityId())
     -- Primary hand, or single-hand equip  
     local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
     --used for checking dual-wield setups
     local opposedhandHeldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand() == "primary" and "alt" or "primary")

	 if species == "floran" then  --consume food in exchange for spear power. Florans also get increased attack speed with spears and a chance to spawn a projectile
	   self.foodValue = status.resource("food")  --check our Food level
           attackSpeedUp = 1 -- base attackSpeed
           local randValue = math.random(2)  -- chance for projectile
	  if heldItem then
	     if root.itemHasTag(heldItem, "spear") then 
		    status.modifyResource("food", (status.resource("food") * -0.008) )
		    status.setPersistentEffects("floranFoodPowerBonus", {{stat = "powerMultiplier", baseMultiplier = 1.15}})  
		-- attack speed change    
		attackSpeedUp = attackSpeedUp+(self.foodValue/120) 
		-- projectile chance
		if randValue > 1 then
		  projectileId = world.spawnProjectile("razorleaf",self:firePosition(),activeItem.ownerEntityId(),self:aimVector(),false,params)
		end		    
	     end     
	  end
         end

-- Racial weapon projectiles
--  if species == "floran" then  -- the more food a floran has, the faster they can stab with a spear
--  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
--  self.foodValue = status.resource("food")
--  attackSpeedUp = 1
--    if heldItem then
--      if root.itemHasTag(heldItem, "spear") then
--        projectileId = world.spawnProjectile("hellfireprojectile",self:firePosition(),activeItem.ownerEntityId(),self:aimVector(),false,params)        
--      end
--    end
--  end
  -- ***********************************************************************************************************
  -- END FR SPECIALS
  -- ***********************************************************************************************************
  
       
  animator.setAnimationState("swoosh", "fire")
  animator.playSound(self.fireSound or "fire")
  animator.burstParticleEmitter((self.elementalType or self.weapon.elementalType) .. "swoosh")	


  util.wait(self.stances.fire.duration, function()
    local damageArea = partDamageArea("swoosh")
    self.weapon:setDamage(self.damageConfig, damageArea, self.fireTime)
  end)




  -- ***********************************************************************************************************
  -- FR cooldown replace
  -- ***********************************************************************************************************
  
  self.cooldownTimer = math.max(0, self.cooldownTimer - (self.dt*attackSpeedUp))
  
  -- ***********************************************************************************************************
  -- END FR SPECIALS
  -- ***********************************************************************************************************
  
  
  --vanilla cooldown rate
  --self.cooldownTimer = self:cooldownTime()
          
end


-- ***********************************************************************************************************
-- FR SPECIALS  Functions for projectile spawning
-- ***********************************************************************************************************
function MeleeSlash:firePosition()
   return vec2.add(mcontroller.position(), activeItem.handPosition(self.weapon.muzzleOffset))
end

function MeleeSlash:aimVector()
  local aimVector = vec2.rotate({1, 0}, self.weapon.aimAngle + sb.nrand(inaccuracy, 0))
  aimVector[1] = aimVector[1] * mcontroller.facingDirection()
  return aimVector
end
  -- ***********************************************************************************************************
  -- END FR SPECIALS
  -- ***********************************************************************************************************
   
   
function MeleeSlash:cooldownTime()
  status.clearPersistentEffects("floranFoodPowerBonus")
  return self.fireTime - self.stances.windup.duration - self.stances.fire.duration
end

function MeleeSlash:uninit()
  self.weapon:setDamage()
  status.clearPersistentEffects("floranFoodPowerBonus")
  status.clearPersistentEffects("slashbonusdmg")
  status.clearPersistentEffects("hylotlbonusdmg")
  self.meleeCountslash = 0
end



