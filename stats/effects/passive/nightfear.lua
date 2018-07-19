function init()
	nightFearEffects=status.addStatModifierGroup({})
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
	if lightLevel<=9 then
		self.effectValue=0.5+(0.05*lightLevel)
		self.speedValue=1+(0.04*(10-lightLevel))
		
		status.setStatModifierGroup(nightFearEffects,{
			{stat = "maxHealth", baseMultiplier = self.effectValue},
			{stat = "powerMultiplier", baseMultiplier = self.effectValue}
		})
		mcontroller.controlModifiers({speedModifier=speedValue})
	else
		status.setStatModifierGroup(nightFearEffects,{})
	end
end

function uninit()
	status.removeStatModifierGroup(nightFearEffects)
end
