function init()
  effect.addStatModifierGroup({{stat = "maxHealth", amount = 20}})
  effect.addStatModifierGroup({{stat = "energyRegenPercentageRate", amount = 0.530}})
  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", effectiveMultiplier = 0.50}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.05,
			airJumpModifier = 1.10
		})
end

function uninit()
  
end