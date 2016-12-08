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
    {stat = "physicalResistance", amount = 1},
    {stat = "fireResistance", amount = 1},
    {stat = "iceResistance", amount = 1},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = 1} 
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