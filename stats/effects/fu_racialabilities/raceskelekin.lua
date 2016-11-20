function init()
  self.powerModifier = config.getParameter("powerModifier", 0)
  effect.addStatModifierGroup({{stat = "powerMultiplier", amount = self.powerModifier}})
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  
  
  effect.addStatModifierGroup({{stat = "protection", amount = 2 }})
  effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 0.001}})
  
  effect.addStatModifierGroup({{stat = "poisonStatusImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "electricStatusImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "biomecoldImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "biomeradiationImmunity", amount = 1}})
  script.setUpdateDelta(10)
end

function update(dt)

end

function uninit()
  
end