function init()

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
    
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "jungleslowImmunity", amount = 1 },
    {stat = "grit", amount = 0.4 },
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0.3},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0},
    {stat = "radioactiveResistance", amount = -0.5}
  })

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end

function update(dt)
  mcontroller.controlModifiers({ speedModifier = 1.14 })
end

function uninit()
  
end