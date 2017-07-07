require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"



function init()
self.critChance = config.getParameter("critChance", 0)
self.critBonus = config.getParameter("critBonus", 0)
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
  
 -- Primary hand, or single-hand equip  
 local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
 --used for checking dual-wield setups
 local opposedhandHeldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand() == "primary" and "alt" or "primary")

 
   if self.blockCount == nil then 
     self.blockCount = 0 
     self.blockCount2 = 0 
   end
	if status.isResource("food") then
	  self.foodValue = status.resource("food")  --check our Food level
	else
	  self.foodValue = 60
	end
   self.energyValue = status.resource("energy")  --check our energy level
   local species = world.entitySpecies(activeItem.ownerEntityId())
   
	     if species == "glitch" and heldItem then
		      status.setPersistentEffects("floranbonusdmg", {
			{stat = "critChance", amount = 4}
		      })         
	     end	     
            if species == "floran" then
              status.setPersistentEffects("floranbonusdmg", {
                {stat = "critChance", amount = 4},
                {stat = "critBonus", baseMultiplier = 1.2}
              })             
            end   
            if species == "lamia" then  
              self.blockCount = self.blockCount + 1.25
              status.setPersistentEffects("vierabonusdmg", {
                {stat = "powerMultiplier", baseMultiplier = self.blockCount}
              }) 
            end             
            if species == "viera" then 
              self.blockCount = self.blockCount + 1.15
              self.blockCount2 = self.blockCount2 + 1.15
              status.setPersistentEffects("vierabonusdmg", {
                {stat = "powerMultiplier", baseMultiplier = self.blockCount},
                {stat = "maxEnergy", baseMultiplier = self.blockCount2 }
              })  
            end   
            if species == "sergal" then 
              self.blockCount = self.blockCount + 1.15
              status.setPersistentEffects("vierabonusdmg", {
              {stat = "powerMultiplier", baseMultiplier = self.blockCount}
              })  
            end             
--************************************** 
end

   
   
function update(dt, fireMode, shiftHeld)
local species = world.entitySpecies(activeItem.ownerEntityId())
            if species == "floran" then      -- florans move faster when wielding bows
		mcontroller.controlModifiers({speedModifier = 1.15})              
            end
            if species == "lamia" then      -- lamia gain increased speed with bows
		mcontroller.controlModifiers({speedModifier = 1.20})              
            end  
            
  self.weapon:update(dt, fireMode, shiftHeld)
      
end

function uninit()
  status.clearPersistentEffects("floranbonusdmg")
  status.clearPersistentEffects("vierabonusdmg")
  status.clearPersistentEffects("sergalbonusdmg")
  self.blockCount = 0
  self.weapon:uninit()
  activeItem.setInstanceValue("critChanceMultiplier",0 )  -- set crit back to default value
end
