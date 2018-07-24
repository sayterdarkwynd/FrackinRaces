function init()
	--removal of persistent handlers, should be removed after a few weeks.
	status.clearPersistentEffects("feneroxEffects")
	nightarDarkHunterEffects=status.addStatModifierGroup({})
	script.setUpdateDelta(10)
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
	-- day penalty

	if daytime and not underground then
		if lightLevel > 85 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "physicalResistance", amount = -0.15},
				{stat = "powerMultiplier", baseMultiplier = 0.80}
			})		
			mcontroller.controlModifiers({ speedModifier = 0.90 })
		elseif lightLevel > 75 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "physicalResistance", amount = -0.12},
				{stat = "powerMultiplier", baseMultiplier = 0.85}
			})		
			mcontroller.controlModifiers({ speedModifier = 0.95 })
		elseif lightLevel > 65 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "physicalResistance", amount = -0.09},
				{stat = "powerMultiplier", baseMultiplier = 0.90}
			})		
			mcontroller.controlModifiers({ speedModifier = 0.97 })
		elseif lightLevel > 55 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "physicalResistance", amount = -0.05},
				{stat = "powerMultiplier", baseMultiplier = 0.95}
			})
		else
			status.clearStatModifierGroup(nightarDarkHunterEffects)
		end
	elseif not daytime or daytime and underground then
		if lightLevel <= 22 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "powerMultiplier", baseMultiplier = 1.25},
				{stat = "physicalResistance", amount = 0.25}
			})		
		elseif lightLevel <= 24 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "powerMultiplier", baseMultiplier = 1.20},
				{stat = "physicalResistance", amount = 0.225}
			})			
		elseif lightLevel <= 26 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "powerMultiplier", baseMultiplier = 1.18},
				{stat = "physicalResistance", amount = 0.20}
			})		
		elseif lightLevel <= 28 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "powerMultiplier", baseMultiplier = 1.16},
				{stat = "physicalResistance", amount = 0.15}
			})			
		elseif lightLevel <= 30 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "powerMultiplier", baseMultiplier = 1.14},
				{stat = "physicalResistance", amount = 0.12}
			})			
		elseif lightLevel <= 35 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "powerMultiplier", baseMultiplier = 1.12},
				{stat = "physicalResistance", amount = 0.10}
			})			
		elseif lightLevel <= 45 then
			status.setStatModifierGroup(nightarDarkHunterEffects, {
				{stat = "powerMultiplier", baseMultiplier = 1.10},
				{stat = "physicalResistance", amount = 0.05}
			})		
		else
			status.setStatModifierGroup(nightarDarkHunterEffects,{})
		end
	end
end

function uninit()
	status.removeStatModifierGroup(nightarDarkHunterEffects)
end