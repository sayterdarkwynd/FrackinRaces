function init()
  effect.addStatModifierGroup({{stat = "snowslowImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "biomecoldImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", amount = 0.30}})
  self.powerModifier = config.getParameter("powerModifier", 0)
  effect.addStatModifierGroup({{stat = "powerMultiplier", baseMultiplier = self.powerModifier}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.08,
			airJumpModifier = 1.05
		})
end

function uninit()
  
end