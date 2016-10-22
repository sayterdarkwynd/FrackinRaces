function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})
  effect.addStatModifierGroup({{stat = "grit", amount = 0.5}})
  effect.addStatModifierGroup({{stat = "energyRegenBlockTime", amount = 1.25}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.12,
			airJumpModifier = 1.06
		})
end

function uninit()
  
end