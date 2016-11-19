require "/scripts/vec2.lua"
require "/scripts/util.lua"
require "/scripts/activeitem/stances.lua"

function init()
  --*************************************    
  -- FU/FR ADDONS
   if self.blockCount == nil then 
     self.blockCount = 0 
     self.blockCount2 = 0
   end

            if world.entitySpecies(activeItem.ownerEntityId()) == "fenerox" then   -- fenerox get bonus defense and +10% damage with each boomerang
              --main hand
		local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isBoomerang(heldItem) then
                          self.blockCount = self.blockCount + 0.10
                          self.blockCount2 = 1
                          status.setPersistentEffects("bonusdmg", {
                            {stat = "powerMultiplier", amount = self.blockCount},
                            {stat = "protection", amount = self.blockCount2 }
                            })  	
                            local bounds = mcontroller.boundBox()
			end
		end  

	    -- alt hand
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isBoomerang(heldItem) then
                          self.blockCount = self.blockCount + 0.10
                          self.blockCount2 = 1
                          status.setPersistentEffects("bonusdmg", {
                            {stat = "powerMultiplier", amount = self.blockCount},
                            {stat = "protection", amount = self.blockCount2 }
                            })  	
                            local bounds = mcontroller.boundBox()
			end
		end		
            end  
            
            if world.entitySpecies(activeItem.ownerEntityId()) == "bunnykin" then   -- elunite get bonus defense and +12.5% damage with each chakram or boomerang
              --main hand
		local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isChakram(heldItem) or isBoomerang(heldItem) then
                          self.blockCount = self.blockCount + 0.15
                          status.setPersistentEffects("bonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end
		end  

	    -- alt hand
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isChakram(heldItem) or isBoomerang(heldItem) then
                          self.blockCount = self.blockCount + 0.15
                          status.setPersistentEffects("bonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  	
			end
		end		
            end  
            
            if world.entitySpecies(activeItem.ownerEntityId()) == "elunite" then   -- elunite get bonus defense and +12.5% damage with each chakram or boomerang
              --main hand
		local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isChakram(heldItem) or isBoomerang(heldItem) then
                          self.blockCount = self.blockCount + 0.125
                          status.setPersistentEffects("bonusdmg", {
                            {stat = "powerMultiplier", amount = self.blockCount},
                            {stat = "protection", amount = 2}
                          })  	
			end
		end  

	    -- alt hand
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isChakram(heldItem) or isBoomerang(heldItem) then
                          self.blockCount = self.blockCount + 0.125
                          status.setPersistentEffects("bonusdmg", {
                            {stat = "powerMultiplier", amount = self.blockCount},
                            {stat = "protection", amount = 2}
                          })  	
			end
		end		
            end  
            
            if world.entitySpecies(activeItem.ownerEntityId()) == "elunite" then   -- elunite get bonus defense and +12.5% damage with each chakram or boomerang
              --main hand
		local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
		if heldItem ~= nil then
			if isChakram(heldItem) or isBoomerang(heldItem) then
                          self.blockCount = self.blockCount + 0.125
                          status.setPersistentEffects("bonusdmg", {
                            {stat = "powerMultiplier", amount = self.blockCount},
                            {stat = "protection", amount = 2}
                          })  	
			end
		end  

	    -- alt hand
		heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
		if heldItem ~= nil then
			if isChakram(heldItem) or isBoomerang(heldItem) then
                          self.blockCount = self.blockCount + 0.125
                          status.setPersistentEffects("bonusdmg", {
                            {stat = "powerMultiplier", amount = self.blockCount},
                            {stat = "protection", amount = 2}
                          })  	
			end
		end		
            end  
            
            
--************************************** 
  self.projectileType = config.getParameter("projectileType")
  self.projectileParameters = config.getParameter("projectileParameters")
  self.projectileParameters.power = self.projectileParameters.power * root.evalFunction("weaponDamageLevelMultiplier", config.getParameter("level", 1))
  initStances()

  self.cooldownTime = config.getParameter("cooldownTime", 0)
  self.cooldownTimer = self.cooldownTime

  checkProjectiles()
  if storage.projectileIds then
    setStance("throw")
  else
    setStance("idle")
  end

end

function update(dt, fireMode, shiftHeld)
  updateStance(dt)
  checkProjectiles()

  self.cooldownTimer = math.max(0, self.cooldownTimer - dt)

  if self.stanceName == "idle" and fireMode == "primary" and self.cooldownTimer == 0 then
    self.cooldownTimer = self.cooldownTime
    setStance("windup")
  end

  if self.stanceName == "throw" then
    if not storage.projectileIds then
      setStance("catch")
    end
  end

            if world.entitySpecies(activeItem.ownerEntityId()) == "fenerox" then      -- fenerox move faster when wielding boomerangs
		mcontroller.controlModifiers({
				 speedModifier = 1.15
			})              
            end 
            
  updateAim()
end

function uninit()
  status.clearPersistentEffects("bonusdmg")
  self.blockCount = 0
end

function fire()
  if world.lineTileCollision(mcontroller.position(), firePosition()) then
    setStance("idle")
    return
  end

  local params = copy(self.projectileParameters)
  params.powerMultiplier = activeItem.ownerPowerMultiplier()
  params.ownerAimPosition = activeItem.ownerAimPosition()
  if self.aimDirection < 0 then params.processing = "?flipx" end
  local projectileId = world.spawnProjectile(
      self.projectileType,
      firePosition(),
      activeItem.ownerEntityId(),
      aimVector(),
      false,
      params
    )
  if projectileId then
    storage.projectileIds = {projectileId}
  end
  animator.playSound("throw")
end

function checkProjectiles()
  if storage.projectileIds then
    local newProjectileIds = {}
    for i, projectileId in ipairs(storage.projectileIds) do
      if world.entityExists(projectileId) then
        local updatedProjectileIds = world.callScriptedEntity(projectileId, "boomerangProjectileIds")

        if updatedProjectileIds then
          for j, updatedProjectileId in ipairs(updatedProjectileIds) do
            table.insert(newProjectileIds, updatedProjectileId)
          end
        end
      end
    end
    storage.projectileIds = #newProjectileIds > 0 and newProjectileIds or nil
  end
end


-- **********************************
-- FR BONUSES
-- **********************************
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