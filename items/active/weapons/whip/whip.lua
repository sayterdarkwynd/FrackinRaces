require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/scripts/status.lua"
require "/items/active/weapons/weapon.lua"

function init()
  activeItem.setCursor("/cursors/reticle0.cursor")

  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, 0)

  self.primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(self.primaryAbility)

  self.altAbility = getAltAbility()
  if self.altAbility then
    self.weapon:addAbility(self.altAbility)
  end

  --*************************************    
  -- FU/FR ADDONS
   if self.whipCount == nil then 
     self.whipCount = 0 
     self.whipCount2 = 0
   end

            if world.entitySpecies(activeItem.ownerEntityId()) == "novakid" then      
              self.whipCount = self.whipCount + 0.19
              status.setPersistentEffects("nightarbonusdmg", { 
                {stat = "powerMultiplier", amount = self.whipCount} 
              })            
              local bounds = mcontroller.boundBox() 
            end 
            
            if world.entitySpecies(activeItem.ownerEntityId()) == "nightar" then      
              self.whipCount = self.whipCount + 0.19
              self.whipCount2 = self.whipCount2 + 0.11
              status.setPersistentEffects("nightarbonusdmg", {
                {stat = "powerMultiplier", amount = self.whipCount},
                {stat = "maxHealth", baseMultiplier = 1 + self.whipCount2 }
              })            
            end  
            if world.entitySpecies(activeItem.ownerEntityId()) == "vulpes" then      
              self.whipCount = self.whipCount + 0.12
              status.setPersistentEffects("nightarbonusdmg", {{stat = "powerMultiplier", amount = self.whipCount}})            
            end               
            if world.entitySpecies(activeItem.ownerEntityId()) == "slimeperson" then      
              self.whipCount = self.whipCount + 0.25
              status.setPersistentEffects("nightarbonusdmg", {{stat = "powerMultiplier", amount = self.whipCount}}) 
              local bounds = mcontroller.boundBox() 
            end    
            if world.entitySpecies(activeItem.ownerEntityId()) == "gardevan" then      
              self.whipCount = self.whipCount + 0.20
              status.setPersistentEffects("nightarbonusdmg", {{stat = "powerMultiplier", amount = self.whipCount}}) 
              local bounds = mcontroller.boundBox() 
            end              
--************************************** 

  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
            if world.entitySpecies(activeItem.ownerEntityId()) == "slimeperson" then      
		mcontroller.controlModifiers({
				 speedModifier = 1.15
			})              
            end   
            if world.entitySpecies(activeItem.ownerEntityId()) == "novakid" then      
		mcontroller.controlModifiers({
				 speedModifier = 1.10
			})              
            end  
            if world.entitySpecies(activeItem.ownerEntityId()) == "gardevan" then      
		mcontroller.controlModifiers({
				 airJumpModifier = 1.15
				 speedModifier = 1.15
			})              
            end               
end

function uninit()
  status.clearPersistentEffects("nightarbonusdmg")
  self.whipCount = 0
  self.weapon:uninit()
end
