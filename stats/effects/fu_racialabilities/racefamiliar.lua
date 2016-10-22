function init()
effect.addStatModifierGroup({{stat = "maxBreath", amount = 200.0}})
effect.addStatModifierGroup({{stat = "biooozeImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "webstickimmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "spiderwebImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "blacktarImmunity", amount = 1}})
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  
  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
	   speedModifier = 1.05
	})
end

function uninit()
  
end