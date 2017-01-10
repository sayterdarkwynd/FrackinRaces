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

-- Novakid get bonus with Pistols and Sniper Rifles
 if world.entitySpecies(activeItem.ownerEntityId()) == "novakid" then   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "pistol") then 
	  self.blockCount = self.blockCount + 0.125
	  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})    
     end
     if root.itemHasTag(heldItem, "sniperrifle") or root.itemHasTag(heldItem, "rifle") then 
	  self.blockCount = self.blockCount + 0.165
	  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})    
     end
  end
end 
-- Apex get a bonus with Grenade Launchers
 if world.entitySpecies(activeItem.ownerEntityId()) == "apex" then   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "grenadelauncher") then 
	  self.blockCount = self.blockCount + 0.19
	  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})   
     end
  end
end 
-- Humans rock the Assault Rifle and SMG
 if world.entitySpecies(activeItem.ownerEntityId()) == "human" then   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "assaultrifle") or root.itemHasTag(heldItem, "machinepistol") then 
	  self.blockCount = self.blockCount + 0.15
	  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}}) 
     end
  end
end           
-- Nightar rock the Assault Rifle
 if world.entitySpecies(activeItem.ownerEntityId()) == "nightar" then   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "assaultrifle") then 
	  self.blockCount = self.blockCount + 0.15
	  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}}) 
     end
  end
end     
-- Vespoids snipe and smg
 if world.entitySpecies(activeItem.ownerEntityId()) == "vespoid" then   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "machinepistol") or root.itemHasTag(heldItem, "sniperrifle") or root.itemHasTag(heldItem, "rifle") then 
	  self.blockCount = self.blockCount + 0.25
	  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
     end
  end
end     
-- gyrusens rock the heavy weapons
 if world.entitySpecies(activeItem.ownerEntityId()) == "vespoid" then   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "rocketlauncher") or root.itemHasTag(heldItem, "grenadelauncher") then 
	  self.blockCount = self.blockCount + 0.20
	  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
     end
  end
end            
          
--************************************** 
-- END FR BONUSES
-- *************************************


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
