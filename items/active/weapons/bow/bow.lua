require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
  activeItem.setCursor("/cursors/reticle0.cursor")

  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, 0)

  local primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(primaryAbility)

  local secondaryAttack = getAltAbility(self.weapon.elementalType)
  if secondaryAttack then
    self.weapon:addAbility(secondaryAttack)
  end

  self.weapon:init()
  --*************************************    
  -- FU/FR ADDONS
   if self.blockCount == nil then 
     self.blockCount = 0 
   end
  
            if world.entitySpecies(activeItem.ownerEntityId()) == "floran" then      --20% more damage with floran
              self.blockCount = self.blockCount + 0.20
              status.setPersistentEffects("floranbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
            end   
--************************************** 
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)

end

function uninit()
  status.clearPersistentEffects("floranbonusdmg")
  self.blockCount = 0
  self.weapon:uninit()
end
