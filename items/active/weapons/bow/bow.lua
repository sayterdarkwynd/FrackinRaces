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
     self.blockCount2 = 0 
   end
	if status.isResource("food") then
	  self.foodValue = status.resource("food")  --check our Food level
	else
	  self.foodValue = 60
	end
   self.energyValue = status.resource("energy")  --check our energy level
   local species = world.entitySpecies(activeItem.ownerEntityId())
            if species == "floran" then      --20% more damage with floran
              self.blockCount = self.blockCount + 1.20
              status.setPersistentEffects("floranbonusdmg", {
                {stat = "powerMultiplier", baseMultiplier = self.blockCount}
              })  
              local bounds = mcontroller.boundBox()            
            end   
            if species == "lamia" then      --25% more damage and increased crit rate with lamia     
              self.blockCount = self.blockCount + 1.25
              status.setPersistentEffects("vierabonusdmg", {
                {stat = "powerMultiplier", baseMultiplier = self.blockCount}
              }) 
              local bounds = mcontroller.boundBox()
            end             
            if species == "viera" then      --25% more damage with viera
              self.blockCount = self.blockCount + 1.15
              self.blockCount2 = self.blockCount2 + 1.15
              status.setPersistentEffects("vierabonusdmg", {
                {stat = "powerMultiplier", baseMultiplier = self.blockCount},
                {stat = "maxEnergy", baseMultiplier = self.blockCount2 }
              })  
            end   
            if species == "sergal" then      --15% more damage with sergal
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
