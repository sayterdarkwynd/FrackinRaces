function init()
	status.clearPersistentEffects("feneroxEffects")
	self.healingRate = 1.007 / config.getParameter("healTime", 220)
	self.powerBonus=config.getParameter("powerBonus",0)
	script.setUpdateDelta(10)
	darkRegenFenerox=status.addStatModifierGroup({})
end
--[[--isnt used, go figure
function getLight()
	local position = mcontroller.position()
	position[1] = math.floor(position[1])
	position[2] = math.floor(position[2])
	local lightLevel = world.lightLevel(position)
	lightLevel = math.floor(lightLevel * 100)
	return lightLevel
end
]]

function nighttimeCheck()
	return world.timeOfDay() > 0.5 -- true if night
end

function undergroundCheck()
	return world.underground(mcontroller.position()) 
end

function update(dt)
	self.foodValue = status.isResource("food") and status.resource("food") or 70

	if nighttimeCheck() or undergroundCheck() and (self.foodValue >= 45) then
		status.modifyResourcePercentage("health", self.healingRate * dt)
		status.setStatModifierGroup(darkRegenFenerox, {
			{stat = "energyRegenPercentageRate", amount = self.powerBonus},
			{stat = "maxHealth", baseMultiplier = self.powerBonus + 1.08},
			{stat = "powerMultiplier", baseMultiplier = self.powerBonus + 1.08}
		})
	else
		status.setStatModifierGroup(darkRegenFenerox,{})
	end
end

function uninit()
	status.removeStatModifierGroup(darkRegenFenerox)
end