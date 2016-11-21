function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  

  effect.addStatModifierGroup({{stat = "biooozeImmunity", amount = 1 }})
  effect.addStatModifierGroup({{stat = "insanityImmunity", amount = 1 }})
  effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 0.7}})
  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end

function update(dt)

end

function uninit()
  
end