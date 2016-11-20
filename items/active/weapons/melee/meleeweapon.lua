require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
  animator.setGlobalTag("paletteSwaps", config.getParameter("paletteSwaps", ""))
  animator.setGlobalTag("directives", "")
  animator.setGlobalTag("bladeDirectives", "")

  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, util.toRadians(config.getParameter("baseWeaponRotation", 0)))
  self.weapon:addTransformationGroup("swoosh", {0,0}, math.pi/2)

  local primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(primaryAbility)

  local secondaryAttack = getAltAbility()
  if secondaryAttack then
    self.weapon:addAbility(secondaryAttack)
  end



-- **************************************************
-- FR EFFECTS
-- **************************************************
   if self.blockCount == nil then 
     self.blockCount = 0
   end
   if self.blockCount2 == nil then 
     self.blockCount2 = 0
   end       
            if world.entitySpecies(activeItem.ownerEntityId()) == "hylotl" then  --hylotl get protection when swinging their weapon
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isDagger(heldItem) or isHammer(heldItem) or isBroadsword(heldItem) or isSpear(heldItem) or isAxe(heldItem) then
              			self.blockCount = self.blockCount + 1
              			status.setPersistentEffects("hylotlbonusdmg", {{stat = "protection", amount = self.blockCount}})    	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if  isDagger(heldItem) or isHammer(heldItem) or isBroadsword(heldItem) or isSpear(heldItem) or isAxe(heldItem) then
              			self.blockCount = self.blockCount + 1
              			status.setPersistentEffects("hylotlbonusdmg", {{stat = "protection", amount = self.blockCount}})   	
			end
		end
            end  

            if world.entitySpecies(activeItem.ownerEntityId()) == "floran" then  --florans get defense bonuses when using spears, and increased damage
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isSpear(heldItem) then
              			self.blockCount = self.blockCount + 2
              			self.blockCount2 = self.blockCount2 + 0.14
              			status.setPersistentEffects("hylotlbonusdmg", {
              			  {stat = "protection", amount = self.blockCount},
              			  {stat = "powerMultiplier", amount = self.blockCount2}
              			})    	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if  isSpear(heldItem) then
              			self.blockCount = self.blockCount + 2
              			self.blockCount2 = self.blockCount2 + 0.14
              			status.setPersistentEffects("hylotlbonusdmg", {
              			  {stat = "protection", amount = self.blockCount},
              			  {stat = "powerMultiplier", amount = self.blockCount2}
              			})   	
			end
		end
            end 

            if world.entitySpecies(activeItem.ownerEntityId()) == "glitch" then  --glitch get bonuses with axe, sword and broadsword, and dagger
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isDagger(heldItem) or isShortsword(heldItem) or isBroadsword(heldItem) or isAxe(heldItem) then
              			self.blockCount = self.blockCount + 0.19
              			status.setPersistentEffects("hylotlbonusdmg", {
              			  {stat = "powerMultiplier", amount = self.blockCount}
              			})    	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isDagger(heldItem) or isBroadsword(heldItem) or isAxe(heldItem) then
              			self.blockCount = self.blockCount + 0.19
              			status.setPersistentEffects("hylotlbonusdmg", {
              			  {stat = "powerMultiplier", amount = self.blockCount}
              			})   	
			end
		end
            end  

          if world.entitySpecies(activeItem.ownerEntityId()) == "human" then      -- Humans do more damage with shortswords
              --main hand
		local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isShortsword(heldItem) then
                          self.blockCount = self.blockCount + 0.19
                          status.setPersistentEffects("hylotlbonusdmg", {
                            {stat = "powerMultiplier", amount = self.blockCount},
                            {stat = "grit", amount = self.blockCount}
                          })  	
			end
		end
	    -- alt hand
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isShortsword(heldItem) then
                          self.blockCount = self.blockCount + 0.19
                          status.setPersistentEffects("hylotlbonusdmg", {
                            {stat = "powerMultiplier", amount = self.blockCount},
                            {stat = "grit", amount = self.blockCount} 
                          })  	
			end
		end	
		 
          end   

          if world.entitySpecies(activeItem.ownerEntityId()) == "wasphive" then      --wasps daggers do 25% more damage
		local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isDagger(heldItem) then
                          self.blockCount = self.blockCount + 0.25
                          status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isDagger(heldItem) then
                          self.blockCount = self.blockCount + 0.25
                          status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end
		end
          end  

             if world.entitySpecies(activeItem.ownerEntityId()) == "apex" then  --apex love axes and hammers
                 local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
 		if heldItem ~= nil then
 			if isHammer(heldItem) or isAxe(heldItem) then
               			self.blockCount = 0.19
               			status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})    	
               			mcontroller.controlModifiers({ speedModifier = 1.15 }) 
 			end
 		end
 		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
 		if heldItem ~= nil then
 			if  isHammer(heldItem) or isAxe(heldItem) then
               			self.blockCount = 0.19
               			status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})
               			mcontroller.controlModifiers({ speedModifier = 1.15 }) 
 			end
 		end
            end  

            if world.entitySpecies(activeItem.ownerEntityId()) == "elunite" then  --elunite get defense bonuses with swords
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isDagger(heldItem) or isShortsword(heldItem) or isBroadsword(heldItem) or isShortsword(heldItem) then
              			self.blockCount = self.blockCount + 2
              			status.setPersistentEffects("hylotlbonusdmg", {
              			  {stat = "protection", amount = self.blockCount},
              			  {stat = "energyRegenPercentageRate", amount = 0.48}
              			})    	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isDagger(heldItem) or isBroadsword(heldItem) or isShortsword(heldItem) then
              			self.blockCount = self.blockCount + 2
              			status.setPersistentEffects("hylotlbonusdmg", {
              			  {stat = "protection", amount = self.blockCount},
              			  {stat = "energyRegenPercentageRate", amount = 0.48}
              			})   	
			end
		end
            end  

            if world.entitySpecies(activeItem.ownerEntityId()) == "fenerox" then  --fenerox get dmg and protection increase with spears
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isSpear(heldItem) then
              			self.blockCount = self.blockCount + 1
              			self.blockCount2 = 0.25
              			status.setPersistentEffects("hylotlbonusdmg", {
              			{stat = "protection", amount = self.blockCount},
              			{stat = "powerMultiplier", amount = self.blockCount2}
              			})          			
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if  isSpear(heldItem) then
              			self.blockCount = self.blockCount + 1
              			self.blockCount2 = 0.25
              			status.setPersistentEffects("hylotlbonusdmg", {
              			{stat = "protection", amount = self.blockCount},
              			{stat = "powerMultiplier", amount = self.blockCount2}
              			})                     			
			end
		end
            end  

            if world.entitySpecies(activeItem.ownerEntityId()) == "viera" then  --viera are dangerous with daggers
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isDagger(heldItem) or isHammer(heldItem) then
              			self.blockCount = self.blockCount + 0.3
              			status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})    	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if  isDagger(heldItem) then
              			self.blockCount = self.blockCount + 0.3
              			status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})   	
			end
		end
            end  
            
            if world.entitySpecies(activeItem.ownerEntityId()) == "vulpes" then  --vulpes get protection when swinging their weapon
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isShortsword(heldItem) or isDagger(heldItem) or isBroadsword(heldItem) then
              			self.blockCount = self.blockCount + 2
              			status.setPersistentEffects("hylotlbonusdmg", {{stat = "protection", amount = self.blockCount}})    	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if  isShortsword(heldItem) or isDagger(heldItem) or isBroadsword(heldItem) then
              			self.blockCount = self.blockCount + 2
              			status.setPersistentEffects("hylotlbonusdmg", {{stat = "protection", amount = self.blockCount}})   	
			end
		end
            end 
            
            
            if world.entitySpecies(activeItem.ownerEntityId()) == "sergal" then  --sergal get health and protection with spears
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isSpear(heldItem) then
              			self.blockCount = self.blockCount + 2
              			status.setPersistentEffects("hylotlbonusdmg", {
              			{stat = "protection", amount = self.blockCount},
              			{ stat = "maxHealth", baseMultiplier = 1.25 }
              			})    	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if  isSpear(heldItem) then
              			self.blockCount = self.blockCount + 2
              			status.setPersistentEffects("hylotlbonusdmg", {
              			{stat = "protection", amount = self.blockCount},
              			{ stat = "maxHealth", baseMultiplier = 1.25 }
              			})   	
			end
		end
            end 

            if world.entitySpecies(activeItem.ownerEntityId()) == "orcana" then  --orcana do extra damage with spears
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isSpear(heldItem) then
              			self.blockCount = 0.25
              			status.setPersistentEffects("hylotlbonusdmg", {
              			{stat = "powerMultiplier", amount = self.blockCount},
              			{ stat = "maxHealth", baseMultiplier = 1.15 }
              			})    	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if  isSpear(heldItem) then
              			self.blockCount = 0.25
              			status.setPersistentEffects("hylotlbonusdmg", {
              			{stat = "powerMultiplier", amount = self.blockCount},
              			{ stat = "maxHealth", baseMultiplier = 1.15 }
              			})   	
			end
		end
            end 

            if world.entitySpecies(activeItem.ownerEntityId()) == "argonian" then  --argonian do extra damage with spears
                local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isSpear(heldItem) then
              			self.blockCount = 0.15
              			status.setPersistentEffects("hylotlbonusdmg", {
              			{stat = "powerMultiplier", amount = self.blockCount},
              			{ stat = "maxEnergy", baseMultiplier = 1.25 }
              			})    	
			end
		end
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if  isSpear(heldItem) then
              			self.blockCount = 0.15
              			status.setPersistentEffects("hylotlbonusdmg", {
              			{stat = "powerMultiplier", amount = self.blockCount},
              			{ stat = "maxEnergy", baseMultiplier = 1.25 }
              			})   	
			end
		end
            end 
            

          
-- ***************************************************            
  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
end




-- ****************************************************************
-- FrackinRaces weapon specialization
-- ****************************************************************
function isDagger(name)
	if root.itemHasTag(name, "dagger") then
		return true
	end
	return false
end

function isSpear(name)
	if root.itemHasTag(name, "spear") then
		return true
	end
	return false
end

function isShortsword(name)
	if root.itemHasTag(name, "shortsword") then
		return true
	end
	return false
end

function isAxe(name)
	if root.itemHasTag(name, "axe") then
		return true
	end
	return false
end

function isHammer(name)
	if root.itemHasTag(name, "hammer") then
		return true
	end
	return false
end

function isBroadsword(name)
	if root.itemHasTag(name, "broadsword") then
		return true
	end
	return false
end

function isFist(name)
	if root.itemHasTag(name, "fist") then
		return true
	end
	return false
end

function isWhip(name)
	if root.itemHasTag(name, "whip") then
		return true
	end
	return false
end

function isChakram(name)
	if root.itemHasTag(name, "chakram") then
		return true
	end
	return false
end

function isBoomerang(name)
	if root.itemHasTag(name, "boomerang") then
		return true
	end
	return false
end

function isElder(name)
	if root.itemHasTag(name, "elder") then
		return true
	end
	return false
end

function isMystical(name)
	if root.itemHasTag(name, "mystical") then
		return true
	end
	return false
end

-- ***********************************************************************************************
-- END specialization
-- ***********************************************************************************************



function uninit()
  status.clearPersistentEffects("hylotlbonusdmg")
  self.blockCount = 0
  self.blockCount2 = 0
  self.weapon:uninit()
end
