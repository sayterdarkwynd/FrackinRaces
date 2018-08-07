require "/scripts/vec2.lua"
require "/scripts/util.lua"
require "/scripts/interp.lua"

function init()
    -- regen default
    self.healingRate = 1.01 / config.getParameter("healTime", 220)
    --food defaults
    hungerMax = { pcall(status.resourceMax, "food") }
    hungerMax = hungerMax[1] and hungerMax[2]
    hungerLevel = status.resource("food")
    baseValue = config.getParameter("healthDown",0)*(status.resourceMax("food"))
    self.tickTime = 1.0
    self.tickTimePenalty = 5.0
    self.tickTimer = self.tickTime 
    self.tickTimerPenalty = self.tickTimePenalty
    script.setUpdateDelta(5)    
end

function getLight()
	local position = mcontroller.position()
	position[1] = math.floor(position[1])
	position[2] = math.floor(position[2])
	local lightLevel = world.lightLevel(position)
	lightLevel = math.floor(lightLevel * 100)
	return lightLevel
end


function daytimeCheck()
	return world.timeOfDay() < 0.5 -- true if daytime
end

function undergroundCheck()
	return world.underground(mcontroller.position()) 
end

function update(dt)
	daytime = daytimeCheck()
	underground = undergroundCheck()
	local lightLevel = getLight()
	if status.isResource("food") then
		self.foodValue = status.resource("food")
		hungerLevel = status.resource("food")
	else
		self.foodValue = 50
		hungerLevel = 50
	end
    --food defaults
    hungerMax = { pcall(status.resourceMax, "food") }
    hungerMax = hungerMax[1] and hungerMax[2]


    baseValue = config.getParameter("healthDown",0)*(status.resourceMax("food"))
    self.tickTimer = self.tickTimer - dt
    self.tickTimerPenalty = self.tickTimerPenalty - dt
    self.foodValue = status.resource("food")
	-- Night penalties
	if not daytime then  -- Florans lose HP and Energy when the sun is not out
		status.setPersistentEffects("nightpenalty", { 
		{stat = "maxHealth", baseMultiplier = 0.90 },
		{stat = "maxEnergy", baseMultiplier = 0.70 }
		}) 
		-- when the sun is down, florans lose food
		if (hungerLevel < hungerMax) and ( self.tickTimerPenalty <= 0 ) then
			self.tickTimerPenalty = self.tickTimePenalty
			--reduce the hunger drain if bathed in light
			if lightLevel > 25 then --you can reduce the drain with light
				adjustedHunger = hungerLevel - (hungerLevel * 0.0095)
				status.setResource("food", adjustedHunger)
			else
			-- otherwise we lose normal amount
				adjustedHunger = hungerLevel - (hungerLevel * 0.016)
				status.setResource("food", adjustedHunger)	           
			end	
		end
	end
	
	-- Daytime Abilities
	if daytime then
		status.clearPersistentEffects("nightpenalty")

	-- when a floran is in the sun, has full health and full food, their energy regen rate increases
		local hPerc = world.entityHealth(entity.id())
		if hPerc[1] == 0 or hPerc[2] == 0 then return end
		if (self.foodValue >= 68) and ((hPerc[1] / hPerc[2]) * 100) >= 98 then
			status.setPersistentEffects("hungerBoost", { 
				{stat = "energyRegenBlockTime", amount = -0.35 },
				{stat = "energyRegenPercentageRate", amount = 0.35 }
			}) 	  
		else
			status.clearPersistentEffects("hungerBoost")
		end
	
	  -- when the sun is out, florans regenerate food    
		if (hungerLevel < hungerMax) and ( self.tickTimer <= 0 ) then
			self.tickTimer = self.tickTime
			adjustedHunger = hungerLevel + (hungerLevel * 0.008)
			status.setResource("food", adjustedHunger)
		end		
	       
	   -- When it is sunny and they are well fed, florans regenerate
		if hungerLevel >= 28  then -- 28 is 40% of 70, which is the maxFood value
			if underground and lightLevel < 60 then -- we cant do it well underground
				self.healingRate = 0
				status.modifyResourcePercentage("health", self.healingRate * dt)  
			elseif underground and lightLevel > 60 then -- we cant do it well underground and it costs food
				status.modifyResource("food", (status.resource("food") * -0.005) )
				self.healingRate = 1.00005 / config.getParameter("healTime", 320)
				status.modifyResourcePercentage("health", self.healingRate * dt)
			elseif lightLevel > 95 then
				self.healingRate = 1.0009 / config.getParameter("healTime", 320)
				status.modifyResourcePercentage("health", self.healingRate * dt)
			elseif lightLevel > 90 then
				self.healingRate = 1.0008 / config.getParameter("healTime", 320)
				status.modifyResourcePercentage("health", self.healingRate * dt)
			elseif lightLevel > 80 then
				self.healingRate = 1.00075 / config.getParameter("healTime", 320)
				status.modifyResourcePercentage("health", self.healingRate * dt)
			elseif lightLevel > 70 then
				self.healingRate = 1.0007 / config.getParameter("healTime", 320)
				status.modifyResourcePercentage("health", self.healingRate * dt)
			elseif lightLevel > 65 then
				self.healingRate = 1.0006 / config.getParameter("healTime", 320)
				status.modifyResourcePercentage("health", self.healingRate * dt)
			elseif lightLevel > 55 then
				self.healingRate = 1.0005 / config.getParameter("healTime", 320)
				status.modifyResourcePercentage("health", self.healingRate * dt)
			elseif lightLevel > 45 then
				self.healingRate = 1.0003 / config.getParameter("healTime", 320)
				status.modifyResourcePercentage("health", self.healingRate * dt)
			elseif lightLevel > 35 then
				self.healingRate = 1.0002 / config.getParameter("healTime", 320)
				status.modifyResourcePercentage("health", self.healingRate * dt)
			elseif lightLevel > 25 then
				self.healingRate = 1.0001 / config.getParameter("healTime", 320)
				status.modifyResourcePercentage("health", self.healingRate * dt)
			end  
		end
	end
end

function uninit()
	status.clearPersistentEffects("hungerBoost")
	status.clearPersistentEffects("nightpenalty")
end







