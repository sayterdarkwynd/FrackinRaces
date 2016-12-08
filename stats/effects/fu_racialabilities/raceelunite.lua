function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "electricStatusImmunity", amount = 1},
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "physicalResistance", amount = 1},
    {stat = "fireResistance", amount = 1},
    {stat = "iceResistance", amount = 1},
    {stat = "electricResistance", amount = 2},
    {stat = "poisonResistance", amount = 1} 
  })

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