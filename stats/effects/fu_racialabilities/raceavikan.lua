function init()
effect.addStatModifierGroup({{stat = "fireStatusImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "biomeheatImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "maxHealth", amount = 20}})
  script.setUpdateDelta(0)
end

function update(dt)

end

function uninit()
  
end