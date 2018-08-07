function init()
	--removal of persistent handlers, should be removed after a few weeks.
	for _,_ in pairs(status.getPersistentEffects("webberEffects")) do
		status.clearPersistentEffects("webberEffects")
		break
	end
	
	nightFearEffects=effect.addStatModifierGroup({})
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

function update(dt)
  local lightLevel = getLight()
	if lightLevel <= 10 then
		effect.setStatModifierGroup(nightFearEffects,{
			{stat = "maxHealth", baseMultiplier = 0.95},
			{stat = "powerMultiplier", baseMultiplier = 0.95}
		})
		mcontroller.controlModifiers({speedModifier=1.1})
	else
		effect.setStatModifierGroup(nightFearEffects,{})
	end
end

function uninit()
	effect.removeStatModifierGroup(nightFearEffects)
end
