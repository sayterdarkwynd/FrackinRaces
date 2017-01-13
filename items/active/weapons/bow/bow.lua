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
  
            if world.entitySpecies(activeItem.ownerEntityId()) == "floran" then      --20% more damage with floran
              self.blockCount = self.blockCount + 1.20
              status.setPersistentEffects("floranbonusdmg", {{stat = "powerMultiplier", baseMultiplier = self.blockCount}})  
              local bounds = mcontroller.boundBox()            
            end   
            if world.entitySpecies(activeItem.ownerEntityId()) == "lamia" then      --25% more damage with lamia
              self.blockCount = self.blockCount + 1.25
              self.blockCount2 = self.blockCount2 + 1.15
              status.setPersistentEffects("vierabonusdmg", {
              {stat = "powerMultiplier", baseMultiplier = self.blockCount},
              {stat = "maxEnergy", baseMultiplier = self.blockCount }
              }) 
              local bounds = mcontroller.boundBox()
            end             
            if world.entitySpecies(activeItem.ownerEntityId()) == "viera" then      --25% more damage with viera
              self.blockCount = self.blockCount + 1.25
              self.blockCount = self.blockCount2 + 1.15
              status.setPersistentEffects("vierabonusdmg", {
              {stat = "powerMultiplier", baseMultiplier = self.blockCount},
              {stat = "maxEnergy", baseMultiplier = self.blockCount2 }
              })  
            end   
            if world.entitySpecies(activeItem.ownerEntityId()) == "sergal" then      --15% more damage with sergal
              self.blockCount = self.blockCount + 1.15
              status.setPersistentEffects("vierabonusdmg", {{stat = "powerMultiplier", baseMultiplier = self.blockCount}})  
            end             
--************************************** 
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
            if world.entitySpecies(activeItem.ownerEntityId()) == "floran" then      -- florans move faster when wielding bows
		mcontroller.controlModifiers({
				 speedModifier = 1.15
			})              
            end
            if world.entitySpecies(activeItem.ownerEntityId()) == "lamia" then      -- florans move faster when wielding bows
		mcontroller.controlModifiers({
				 speedModifier = 1.20
			})              
            end         
end

function uninit()
  status.clearPersistentEffects("floranbonusdmg")
  status.clearPersistentEffects("vierabonusdmg")
  status.clearPersistentEffects("sergalbonusdmg")
  self.blockCount = 0
  self.weapon:uninit()
end
