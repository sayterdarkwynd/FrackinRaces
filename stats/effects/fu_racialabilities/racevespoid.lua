function init()

  baseValue3 = config.getParameter("foodBonus",0)*(status.resourceMax("food"))
  effect.addStatModifierGroup({{stat = "maxFood", amount = baseValue3 }})
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  
  self.movementParams = mcontroller.baseParameters()  
  
  effect.addStatModifierGroup({{stat = "beestingImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "honeyslowImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", effectiveMultiplier = 0.20}})
  local bounds = mcontroller.boundBox()	
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
	 speedModifier = 1.08,
	 stickyForce = 1.0,
	 airForce = 35.0,
	 liquidForce = 20.0
	})
end

function uninit()
  
end