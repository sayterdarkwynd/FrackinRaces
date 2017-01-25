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

-- **************************
-- FR values
  species = world.entitySpecies(activeItem.ownerEntityId())
  critValueBase = config.getParameter("critChance") -- reset crit chance  
  critModifier = config.getParameter("critModifier",5) -- add to crit chance 
	if status.isResource("food") then
	  self.foodValue = status.resource("food")  --check our Food level
	else
	  self.foodValue = 60
	end
  attackSpeedUp = 1 -- base attackSpeed
-- ************************************************

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
  self:setState(self.fire)
end



-- ***********************************************************************************************************
-- FR SPECIALS  Functions for projectile spawning
-- ***********************************************************************************************************
function MeleeSlash:firePosition()
   return vec2.add(mcontroller.position(), activeItem.handPosition(self.weapon.muzzleOffset))
end

function MeleeSlash:aimVector()  -- fires straight
  local aimVector = vec2.rotate({1, 0}, self.weapon.aimAngle )
  aimVector[1] = aimVector[1] * mcontroller.facingDirection()
  return aimVector
end

function MeleeSlash:aimVectorRand() -- fires wherever it wants
  local aimVector = vec2.rotate({1, 0}, self.weapon.aimAngle + sb.nrand(inaccuracy, 0))
  aimVector[1] = aimVector[1] * mcontroller.facingDirection()
  return aimVector
end
  -- ***********************************************************************************************************
  -- END FR SPECIALS
  -- ***********************************************************************************************************
   
   
   
   
-- State: fire
function MeleeSlash:fire()
     
  self.weapon:setStance(self.stances.fire)
  self.weapon:updateAim()



      -- ******************************************************************************************************************
      -- FR RACIAL BONUSES FOR WEAPONS   --- Bonus effect when attacking 
      -- ******************************************************************************************************************
	-- *** ABILITY TYPES
	-- attackSpeedUp = attackSpeedUp+(self.foodValue/120)  -- Attack Speed increase based on food. easily modified
	-- activeItem.setInstanceValue("critChance",math )  -- crit chance: 
	-- activeItem.setInstanceValue("critBonus",math )  -- Crit Bonus increase 
	-- activeItem.setInstanceValue("elementalType","element" )  -- attack element type 
	-- activeItem.setInstanceValue("primaryAbility","ability" )  -- ability
	-- projectileId = world.spawnProjectile("hellfireprojectile",self:firePosition(),activeItem.ownerEntityId(),self:aimVector(),false,params)     -- spawn a projectile

      
     local species = world.entitySpecies(activeItem.ownerEntityId())
     -- Primary hand, or single-hand equip  
     local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
     --used for checking dual-wield setups
     local opposedhandHeldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand() == "primary" and "alt" or "primary")
     local randValue = math.random(100)  -- chance for projectile  
      
     -- **** FLORAN
     local randValueCritBonus = math.random(10)
     

	 if species == "floran" then  --consume food in exchange for spear power. Florans also get increased attack speed with spears and a chance to spawn a projectile
	  local critValueFloran = ( randValueCritBonus + math.ceil(self.foodValue/10) ) 
	  if status.isResource("food") then
	      self.foodValue = status.resource("food")
	  else
	      self.foodValue = 50
	  end          
          attackSpeedUp = 1 -- base attackSpeed
	  if heldItem then
	     if not root.itemHasTag(heldItem, "spear") then  -- anything that isn't a spear gets a flat damage bonus
	       if self.foodValue >= 5 then
		  if status.isResource("food") then
		   status.modifyResource("food", (status.resource("food") * -0.005) )
		  end	 	       
	         status.setPersistentEffects("floranFoodPowerBonus", {{stat = "powerMultiplier", baseMultiplier = 1.05}})
	       end
	     end
	     if root.itemHasTag(heldItem, "spear") then -- spears get increased attack speed and a chance for a special attack. need 50% food or more
		    -- attack speed change  
		    if self.foodValue >= 35 then
		      if status.isResource("food") then
		        status.modifyResource("food", (status.resource("food") * -0.01) )  -- consume food
		      end
		      attackSpeedUp = attackSpeedUp+(self.foodValue/120) 
			    status.setPersistentEffects("combobonusdmg", {
			      {stat = "critChance", amount = critValueFloran}
			    }) 		      
		    -- projectile chance
		      if randValue < 9 then
			projectileId = world.spawnProjectile("furazorleafinvis",self:firePosition(),activeItem.ownerEntityId(),self:aimVector(),false,params)
		      end			      
		    end
	     end  
	   end
         end

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



