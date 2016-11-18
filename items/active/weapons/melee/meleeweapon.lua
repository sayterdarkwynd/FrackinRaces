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
-- FU EFFECTS
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
              			self.blockCount = self.blockCount + 1
              			self.blockCount2 = self.blockCount2 + 0.19
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
              			self.blockCount2 = self.blockCount2 + 0.19
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
                          status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount} })  	
			end
		end
	    -- alt hand
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isShortsword(heldItem) then
                          self.blockCount = self.blockCount + 0.19
                          status.setPersistentEffects("hylotlbonusdmg", {{stat = "powerMultiplier", amount = self.blockCount} })  	
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
	if root.itemHasTag(name, "chakram") then
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
