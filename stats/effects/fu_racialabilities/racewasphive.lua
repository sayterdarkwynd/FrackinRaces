function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "physicalResistance", amount = 1.15},
    {stat = "fireResistance", amount = -1.5},
    {stat = "iceResistance", amount = -1.5},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = 1} 
  })

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
    if mcontroller.falling() then
      mcontroller.controlParameters(config.getParameter("fallingParameters"))
      mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed")))
    end
	mcontroller.controlModifiers({
	 speedModifier = 1.08,
	 airForce = 45.0,
	 liquidForce = 20.0
	})
end

function uninit()
  
end