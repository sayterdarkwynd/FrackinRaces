function init()
	animator.setParticleEmitterOffsetRegion("healing", mcontroller.boundBox())
	animator.setParticleEmitterActive("healing", true)

	--script.setUpdateDelta(5)

	self.healingRate = 1.005 / config.getParameter("healTime", 60)
	bonusHandler=effect.addStatModifierGroup({{stat="healthRegen",amount=status.stat("maxHealth")*self.healingRate}})
end

--[[function update(dt)
	--sb.logInfo("regenminor")
	--status.modifyResourcePercentage("health", self.healingRate * dt)
	--effect.setStatModifierGroup(bonusHandler,{{stat="healthRegen",amount=status.stat("maxHealth")*self.healingRate}})
end]]

function uninit()
	effect.removeStatModifierGroup(bonusHandler)
end