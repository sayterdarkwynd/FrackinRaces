function init()
  effect.addStatModifierGroup({{stat = "electricStatusImmunity", amount = 1}})
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  
  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)


end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.04,
			airJumpModifier = 1.05,
			liquidImpedance = 0.6,
			minimumLiquidPercentage = 0.4,
			liquidForce = 25,
			groundForce = 115
		})	
end

function uninit()
  
end