function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "liquidnitrogenImmunity", amount = 1},
    {stat = "biomecoldImmunity", amount = 1},
    {stat = "iceslipImmunity", amount = 1},
    {stat = "iceStatusImmunity", amount = 1},
    {stat = "physicalResistance", amount = 1},
    {stat = "fireResistance", amount = -2},
    {stat = "iceResistance", amount = 2},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = 1}  
  })
  
  script.setUpdateDelta(0)
 
end

function update(dt)

end

function uninit()
  
end