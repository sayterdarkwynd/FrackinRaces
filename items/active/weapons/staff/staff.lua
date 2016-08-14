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
   if self.blockCount == nil then 
     self.blockCount = 0 
   end
  
            if world.entitySpecies(activeItem.ownerEntityId()) == "avian" then      --20% more damage with floran
              self.blockCount = self.blockCount + 0.20
              status.setPersistentEffects("avianbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
            end   
--************************************** 
  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
end

function uninit()
  status.clearPersistentEffects("avianbonusdmg")
  self.blockCount = 0
  self.weapon:uninit()
end
