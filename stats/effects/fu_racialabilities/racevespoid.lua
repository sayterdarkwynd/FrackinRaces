function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  baseValue3 = config.getParameter("foodBonus",0)*(status.resourceMax("food"))
  
  effect.addStatModifierGroup({
    {stat = "maxFood", amount = baseValue3 },
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "beestingImmunity", amount = 1},
    {stat = "honeyslowImmunity", amount = 1},
    {stat = "fallDamageMultiplier", effectiveMultiplier = 0.20},
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.75},
    {stat = "iceResistance", amount = -0.5},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0.5} 
  })

  self.movementParams = mcontroller.baseParameters()  
  local bounds = mcontroller.boundBox()	
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
	 speedModifier = 1.10,
	 stickyForce = 2,
	 airForce = 65.0,
	 liquidForce = 20.0
	})
end

function uninit()
  
end