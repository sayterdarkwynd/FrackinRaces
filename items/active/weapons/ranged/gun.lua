require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
self.critChance = config.getParameter("critChance", 0)
self.critBonus = config.getParameter("critBonus", 0)
--*************************************    
-- FU/FR ADDONS
 if self.blockCount == nil then 
   self.blockCount = 0 
 end
 if self.blockCount2 == nil then 
   self.blockCount2 = 0 
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
		  status.setPersistentEffects("novakidbonusdmg2", {
		    {stat = "critChance", amount = 5},
		    {stat = "critBonus", baseMultiplier = 1.2 }
		    })    
	     end
	     if root.itemHasTag(heldItem, "shotgun") then 
		  status.setPersistentEffects("novakidbonusdmg2", {
		    {stat = "powerMultiplier", baseMultiplier = 1.2},
		    {stat = "critBonus", baseMultiplier = 1.2}
		    })    
	     end	     
	     if root.itemHasTag(heldItem, "pistol") and opposedhandHeldItem and root.itemHasTag(opposedhandHeldItem, "pistol") then -- novakids are unmatched with dual pistols
	       status.setPersistentEffects("weaponbonusdualwield", {
		    {stat = "grit", amount = 0.25},
		    {stat = "maxEnergy", baseMultiplier = 1.15}
		 })    
	     end	     
	  end
	end 

	-- glitch love crossbows
	if species == "glitch" and heldItem then   	     
	     if root.itemHasTag(heldItem, "crossbow") then 
		  status.setPersistentEffects("novakidbonusdmg", {
		    {stat = "critChance", baseMultiplier = 4}
		  })   
	     end	     
	end
	-- avikan love energy weapons
	if species == "avikan" and heldItem then   	     
	     if root.itemHasTag(heldItem, "energy") then 
		  status.setPersistentEffects("novakidbonusdmg", {
		    {stat = "critChance", amount = 2},
		    {stat = "powerMultiplier", baseMultiplier = 1.15}
		  })   
	     end	     
	end	
	if species == "argonian" and heldItem then   	     
	     if root.itemHasTag(heldItem, "crossbow") or root.itemHasTag(heldItem, "harpoon") then 
		  status.setPersistentEffects("novakidbonusdmg", {
		    {stat = "critChance", amount = 5},
		    {stat = "powerMultiplier", amount = 1.15}
		  })   
	     end	     
	end  
	-- argonian love crossbows
	 if species == "avali" and heldItem then   	     
	     if root.itemHasTag(heldItem, "energy") then 
		  status.setPersistentEffects("novakidbonusdmg", {
		    {stat = "powerMultiplier", amount = 1.12}
		  })   
	     end
	     if root.itemHasTag(heldItem, "grenadelauncher") then 
		  status.setPersistentEffects("novakidbonusdmg", {
		    {stat = "critBonus", baseMultiplier = 1.2}
		  })   
	     end	     
	end  
	
	-- Avian get a bonus with submachineguns
	 if species == "avian" then   
	  if heldItem then	     
	     if root.itemHasTag(heldItem, "machinepistol") then 
		  status.setPersistentEffects("novakidbonusdmg", {
		    {stat = "critChance", baseMultiplier = 1}
		  })   
	     end	     
	  end
	end 
	
	-- Callistan get a bonus with Energy Weapons
	 if species == "callistan" then   
	  if heldItem then	     
	     if root.itemHasTag(heldItem, "energy") then 
		  self.blockCount = 1.15
		  self.blockCount2 = 1.25
		  status.setPersistentEffects("novakidbonusdmg", {
		    {stat = "powerMultiplier", baseMultiplier = self.blockCount},
		    {stat = "maxEnergy", baseMultiplier = self.blockCount},
		    {stat = "energyRegenPercentageRate", baseMultiplier = self.blockCount2},
		    {stat = "critBonus", baseMultiplier = self.blockCount2}
		  })   
	     end	     
	  end
	end 
	
	-- Floran get a bonus with floran needlers
	 if species == "floran" then   
	  if heldItem then
	     if root.itemHasTag(heldItem, "floran") then 
		  status.setPersistentEffects("novakidbonusdmg", {
		    {stat = "critChance", amount = 2}
		  })   
	     end 	     
	  end
	end 
	
	-- Apex get a bonus with mining lasers
	 if species == "apex" then   
	  if heldItem then
	     if root.itemHasTag(heldItem, "mininglaser") then 
		  status.setPersistentEffects("novakidbonusdmg", {
		    {stat = "powerMultiplier", baseMultiplier = 1.5}
		  })   
	     end 	     
	  end
	end 
	
	-- Humans rock the Assault Rifle and SMG
	 if species == "human" then   
	  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
	  if heldItem then
	     if root.itemHasTag(heldItem, "assaultrifle") then 
		  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", baseMultiplier = 1.12}}) 
	     end
	  end
	end           
    
-- Vespoids snipe and smg
 if species == "vespoid" then   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "machinepistol") or root.itemHasTag(heldItem, "sniperrifle") or root.itemHasTag(heldItem, "rifle") then 
	  self.blockCount = self.blockCount + 0.15
	  status.setPersistentEffects("novakidbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
     end
  end
end     
-- gyrusens rock the heavy weapons
 if species == "gyrusen" then   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "rocketlauncher") or root.itemHasTag(heldItem, "grenadelauncher") then 
	  self.blockCount = self.blockCount + 0.15
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
if species == "novakid" and bonusApply == 0 then  --nightar gain speed and jump when wielding pistols
  if heldItem then
     if root.itemHasTag(heldItem, "pistol") and opposedhandHeldItem and root.itemHasTag(opposedhandHeldItem, "pistol") then
       mcontroller.controlModifiers({ speedModifier = 1.08, airJumpModifier = 1.05 })
     end    
  end
  bonusApply = 1
end

-- ***********  floran  movement bonuses ***************
if species == "flora" and bonusApply == 0 then  
  if heldItem then
     if root.itemHasTag(heldItem, "floran") and opposedhandHeldItem and root.itemHasTag(opposedhandHeldItem, "floran") then
       mcontroller.controlModifiers({ speedModifier = 1.08 })
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
  status.clearPersistentEffects("novakidbonusdmg2")
  self.blockCount = 0
  self.weapon:uninit()
end
