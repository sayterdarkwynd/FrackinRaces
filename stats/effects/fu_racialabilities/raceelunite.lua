function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "electricStatusImmunity", amount = 1},
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = 0.8},
    {stat = "poisonResistance", amount = 0} 
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