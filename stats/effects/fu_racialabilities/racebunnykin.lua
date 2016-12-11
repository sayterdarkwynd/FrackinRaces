function init()

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "slimestickImmunity", amount = 1},
    {stat = "jungleslowImmunity", amount = 1 },
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.8},
    {stat = "iceResistance", amount = 0.5},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0} 
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