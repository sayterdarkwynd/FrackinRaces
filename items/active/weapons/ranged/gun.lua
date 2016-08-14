require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
--*************************************    
-- FU/FR ADDONS
 if self.blockCount == nil then 
   self.blockCount = 0 
 end

          if world.entitySpecies(activeItem.ownerEntityId()) == "novakid" then      --8% more damage with novakid
            self.blockCount = self.blockCount + 0.08
            status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
          end   
--************************************** 
  activeItem.setCursor("/cursors/reticle0.cursor")
  animator.setGlobalTag("paletteSwaps", config.getParameter("paletteSwaps", ""))

  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, 0)
  self.weapon:addTransformationGroup("muzzle", self.weapon.muzzleOffset, 0)

  local primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(primaryAbility)

  local secondaryAbility = getAltAbility(self.weapon.elementalType)
  if secondaryAbility then
    self.weapon:addAbility(secondaryAbility)
  end

  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
end

function uninit()
  status.clearPersistentEffects("novakidbonusdmg")
  self.blockCount = 0
  self.weapon:uninit()
end
