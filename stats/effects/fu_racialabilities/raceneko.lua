function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})
  effect.addStatModifierGroup({{stat = "energyRegenPercentageRate", amount = 0.530}})
  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", effectiveMultiplier = 0.50}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.15,
			airJumpModifier = 1.10
		})
end

function uninit()
  
end