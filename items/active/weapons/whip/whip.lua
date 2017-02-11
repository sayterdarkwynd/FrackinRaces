require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/scripts/status.lua"
require "/items/active/weapons/weapon.lua"

function init()
self.critChance = config.getParameter("critChance", 0)
self.critBonus = config.getParameter("critBonus", 0)
  activeItem.setCursor("/cursors/reticle0.cursor")

  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, 0)

  self.primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(self.primaryAbility)

  self.altAbility = getAltAbility()
  if self.altAbility then
    self.weapon:addAbility(self.altAbility)
  end

  --*************************************    
  -- FU/FR ADDONS
   if self.whipCount == nil then 
     self.whipCount = 0 
     self.whipCount2 = 0
   end
   
   local species = world.entitySpecies(activeItem.ownerEntityId())

            if species == "novakid" then      
              self.whipCount = self.whipCount + 1.19
              status.setPersistentEffects("nightarbonusdmg", { 
                {stat = "powerMultiplier", baseMultiplier = self.whipCount} 
              })            
            end 
            if species == "lamia" then      
              self.whipCount = self.whipCount + 1.06
              status.setPersistentEffects("lamiabonusdmg", { 
                {stat = "protection", baseMultiplier = self.whipCount} 
              })            
            end             
            if species == "nightar" then      
              self.whipCount = self.whipCount + 1.19
              self.whipCount2 = self.whipCount2 + 1.11
              status.setPersistentEffects("nightarbonusdmg", {
                {stat = "powerMultiplier", baseMultiplier = self.whipCount},
                {stat = "maxHealth", baseMultiplier = self.whipCount2 }
              })            
            end  
            if species == "vulpes" then      
              self.whipCount = self.whipCount + 1.12
              status.setPersistentEffects("nightarbonusdmg", {{stat = "powerMultiplier", baseMultiplier = self.whipCount}})            
            end               
            if species == "slimeperson" then      
              self.whipCount = self.whipCount + 1.25
              status.setPersistentEffects("nightarbonusdmg", {{stat = "powerMultiplier", baseMultiplier = self.whipCount}}) 
            end    
            if species == "gardevan" then      
              self.whipCount = self.whipCount + 1.20
              status.setPersistentEffects("nightarbonusdmg", {{stat = "powerMultiplier", baseMultiplier = self.whipCount}}) 
            end              
--************************************** 

  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
  
  -- *********** FR STUFF  *************************** 
            local species = world.entitySpecies(activeItem.ownerEntityId())
            if species == "slimeperson" then      
		mcontroller.controlModifiers({
				 speedModifier = 1.15
			})              
            end   
            if species == "novakid" then      
		mcontroller.controlModifiers({
				 speedModifier = 1.10
			})              
            end  
            if species == "gardevan" then      
		mcontroller.controlModifiers({
				 airJumpModifier = 1.15,
				 speedModifier = 1.15
			})              
            end   
-- ***********************************************
end

function uninit()
  status.clearPersistentEffects("nightarbonusdmg")
  status.clearPersistentEffects("lamiabonusdmg")
  self.whipCount = 0
  self.weapon:uninit()
end
