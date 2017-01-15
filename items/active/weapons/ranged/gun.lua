require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
--*************************************    
-- FU/FR ADDONS
 if self.blockCount == nil then 
   self.blockCount = 0 
 end

local species = world.entitySpecies(activeItem.ownerEntityId())

 -- Primary hand, or single-hand equip  
local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
local heldItem2 = world.entityHandItem(activeItem.ownerEntityId(), "alt")
 --used for checking dual-wield setups
 local opposedhandHeldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand() == "primary" and "alt" or "primary")

          if species == "peglaci" then      
            self.blockCount = self.blockCount + 0.05
            status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
          end  
          if species == "vulpes" then     
            self.blockCount = self.blockCount + 0.08
            status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
          end        

	-- Novakid get bonus with Pistols and Sniper Rifles
	 if species == "novakid" then   
	  if heldItem then
	     if root.itemHasTag(heldItem, "pistol") then 
		  self.blockCount = self.blockCount + 0.09
		  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})    
	     end
	     if root.itemHasTag(heldItem, "sniperrifle") or root.itemHasTag(heldItem, "rifle") then 
		  self.blockCount = self.blockCount + 0.165
		  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})    
	     end
	     if root.itemHasTag(heldItem, "pistol") and opposedhandHeldItem and root.itemHasTag(opposedhandHeldItem, "pistol") then -- novakids are unmatched with dual pistols
	       self.meleeCount = self.meleeCount + 0.20
	       self.meleeCount2 = self.meleeCount2 + 0.20
	       status.setPersistentEffects("weaponbonusdualwield", {
		    {stat = "powerMultiplier", amount = self.meleeCount},
		    {stat = "grit", amount = self.meleeCount},
		    {stat = "maxEnergy", amount = self.meleeCount2}
		 })        
	     end	     
	  end
	end 

	-- Apex get a bonus with Grenade Launchers
	 if species == "apex" then   
	  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
	  if heldItem then
	     if root.itemHasTag(heldItem, "grenadelauncher") then 
		  self.blockCount = self.blockCount + 0.19
		  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})   
	     end
	  end
	end 
	-- Humans rock the Assault Rifle and SMG
	 if species == "human" then   
	  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
	  if heldItem then
	     if root.itemHasTag(heldItem, "assaultrifle") or root.itemHasTag(heldItem, "machinepistol") then 
		  self.blockCount = self.blockCount + 0.15
		  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}}) 
	     end
	  end
	end           
    
-- Vespoids snipe and smg
 if species == "vespoid" then   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "machinepistol") or root.itemHasTag(heldItem, "sniperrifle") or root.itemHasTag(heldItem, "rifle") then 
	  self.blockCount = self.blockCount + 0.25
	  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
     end
  end
end     
-- gyrusens rock the heavy weapons
 if species == "gyrusen" then   
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

-- ***************************************************   
--FR stuff
-- ***************************************************   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
  local heldItem2 = world.entityHandItem(activeItem.ownerEntityId(), "alt")
  local opposedhandHeldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand() == "primary" and "alt" or "primary")
  local species = world.entitySpecies(activeItem.ownerEntityId())
  local bonusApply = 0
  
  
-- ***********  Novakid  movement bonuses ***************
if species == "novakid" and bonusApply == 0 then  --nightar gain speed and jump when wielding swords
  if heldItem then
     if root.itemHasTag(heldItem, "pistol") and opposedhandHeldItem and root.itemHasTag(opposedhandHeldItem, "pistol") then
       mcontroller.controlModifiers({ speedModifier = 1.08, airJumpModifier = 1.05 })
     end    
  end
  bonusApply = 1
end

-- ***************************************************   
-- END FR STUFF
-- ***************************************************   

  self.weapon:update(dt, fireMode, shiftHeld)
end


function uninit()
  bonusApply = 0
  status.clearPersistentEffects("novakidbonusdmg")
  self.blockCount = 0
  self.weapon:uninit()
end
