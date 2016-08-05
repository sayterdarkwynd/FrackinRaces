function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }}) 
  effect.addStatModifierGroup({{stat = "breathDepletionRate", amount = 2.0 }}) 
  
script.setUpdateDelta(0)

end

function update(dt)

end

function uninit()
  
end