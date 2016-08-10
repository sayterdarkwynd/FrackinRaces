function init()
effect.addStatModifierGroup({{stat = "liquidnitrogenImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "biomecoldImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "iceslipImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "maxEnergy", amount = 20}})
effect.addStatModifierGroup({{stat = "iceStatusImmunity", amount = 1}})
  script.setUpdateDelta(0)
end

function update(dt)

end

function uninit()
  
end