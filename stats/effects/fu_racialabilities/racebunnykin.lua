function init()

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "slimestickImmunity", amount = 1},
    {stat = "jungleslowImmunity", amount = 1 },
    {stat = "physicalResistance", amount = 1},
    {stat = "fireResistance", amount = 1},
    {stat = "iceResistance", amount = 1},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = 1} 
  })  

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.18,
			airJumpModifier = 1.20
		})
end

function uninit()
  
end