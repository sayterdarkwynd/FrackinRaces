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
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -1},
    {stat = "iceResistance", amount = 0.9},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0}  
  })
  
  script.setUpdateDelta(0)
 
end

function update(dt)

end

function uninit()
  
end