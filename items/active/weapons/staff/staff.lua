require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
  activeItem.setCursor("/cursors/reticle0.cursor")
  animator.setGlobalTag("paletteSwaps", config.getParameter("paletteSwaps", ""))

  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, 0)

  local primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(primaryAbility)

  local secondaryAttack = getAltAbility(self.weapon.elementalType)
  if secondaryAttack then
    self.weapon:addAbility(secondaryAttack)
  end
  --*************************************    
  -- FU/FR ADDONS
   if self.staffCount == nil then 
     self.staffCount = 0 
   end
  
            if world.entitySpecies(activeItem.ownerEntityId()) == "avian" then      
              self.staffCount = self.staffCount + 0.20
              status.setPersistentEffects("avianbonusdmg", {{stat = "powerMultiplier", amount = self.staffCount}})  
            end 
            if world.entitySpecies(activeItem.ownerEntityId()) == "nightar" then     
              self.staffCount = self.staffCount + 0.12
              status.setPersistentEffects("ningenbonusdmg", {{stat = "protection", amount = self.staffCount}})  
            end              
            if world.entitySpecies(activeItem.ownerEntityId()) == "kineptic" then     
              self.staffCount = self.staffCount + 0.25
              status.setPersistentEffects("ningenbonusdmg", {{stat = "powerMultiplier", amount = self.staffCount}})  
            end             
            if world.entitySpecies(activeItem.ownerEntityId()) == "ningen" then     
              self.staffCount = self.staffCount + 0.15
              status.setPersistentEffects("ningenbonusdmg", {{stat = "powerMultiplier", amount = self.staffCount}})  
            end               
--************************************** 
  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
end

function uninit()
  status.clearPersistentEffects("avianbonusdmg")
  status.clearPersistentEffects("ningenbonusdmg")
  self.staffCount = 0
  self.bonusCount = 0
  self.weapon:uninit()
end
