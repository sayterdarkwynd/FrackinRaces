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
   end
  
            if world.entitySpecies(activeItem.ownerEntityId()) == "nightar" then      
              self.whipCount = self.whipCount + 0.19
              status.setPersistentEffects("nightarbonusdmg", {{stat = "powerMultiplier", amount = self.whipCount}})            
            end  
            if world.entitySpecies(activeItem.ownerEntityId()) == "vulpes" then      
              self.whipCount = self.whipCount + 0.12
              status.setPersistentEffects("nightarbonusdmg", {{stat = "powerMultiplier", amount = self.whipCount}})            
            end               
            if world.entitySpecies(activeItem.ownerEntityId()) == "slimeperson" then      
              self.whipCount = self.whipCount + 0.25
              status.setPersistentEffects("nightarbonusdmg", {{stat = "powerMultiplier", amount = self.whipCount}})            
            end               
--************************************** 

  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
end

function uninit()
  status.clearPersistentEffects("nightarbonusdmg")
  self.whipCount = 0
  self.weapon:uninit()
end
