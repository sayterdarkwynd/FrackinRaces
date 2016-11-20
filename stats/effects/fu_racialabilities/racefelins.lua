function init()
  effect.addStatModifierGroup({{stat = "insanityImmunity", amount = 1}})
  self.powerModifier = config.getParameter("powerModifier", 0)
  effect.addStatModifierGroup({{stat = "powerMultiplier", amount = self.powerModifier}})
  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", effectiveMultiplier = 0.50}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.07,
			airJumpModifier = 1.15
		})
end

function uninit()
  
end