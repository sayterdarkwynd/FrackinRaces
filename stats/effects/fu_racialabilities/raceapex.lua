function init()
  effect.addStatModifierGroup({{stat = "fumudslowImmunity", amount = 1 }})
  effect.addStatModifierGroup({{stat = "jungleslowImmunity", amount = 1 }})
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end

function update(dt)

end

function uninit()
  
end