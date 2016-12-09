function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.65},
    {stat = "iceResistance", amount = 0.4},
    {stat = "electricResistance", amount = -0.15},
    {stat = "poisonResistance", amount = 0.2}   
  })
  
 
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
 
end

function update(dt)
		mcontroller.controlModifiers({
		           speedModifier = 1.05,
			   airJumpModifier = 1.05
			})
end

function uninit()
  
end