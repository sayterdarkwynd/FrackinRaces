require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
--*************************************    
-- FU/FR ADDONS
 if self.blockCount == nil then 
   self.blockCount = 0 
 end
          if world.entitySpecies(activeItem.ownerEntityId()) == "peglaci" then      
            self.blockCount = self.blockCount + 0.05
            status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
          end  
          if world.entitySpecies(activeItem.ownerEntityId()) == "vulpes" then     
            self.blockCount = self.blockCount + 0.08
            status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
          end             
          if world.entitySpecies(activeItem.ownerEntityId()) == "novakid" then      
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





-- ****************************************************************
-- FrackinRaces weapon specialization
-- ****************************************************************

function isPistol(name)
	if root.itemHasTag(name, "pistol") then
		return true
	end
	return false
end

function isAssaultRifle(name)
	if root.itemHasTag(name, "assaultrifle") then
		return true
	end
	return false
end

function isMachinePistol(name)
	if root.itemHasTag(name, "machinepistol") then
		return true
	end
	return false
end

function isRocketLauncher(name)
	if root.itemHasTag(name, "rocketlauncher") then
		return true
	end
	return false
end

function isShotgun(name)
	if root.itemHasTag(name, "shotgun") then
		return true
	end
	return false
end

function isSniperRifle(name)
	if root.itemHasTag(name, "sniperrifle") then
		return true
	end
	return false
end

-- ***********************************************************************************************
-- END specialization
-- ***********************************************************************************************


function uninit()
  status.clearPersistentEffects("novakidbonusdmg")
  self.blockCount = 0
  self.weapon:uninit()
end
