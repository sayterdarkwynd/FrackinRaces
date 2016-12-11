function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "fireStatusImmunity", amount = 1 },
    {stat = "biomeheatImmunity", amount = 1 },
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "foodDelta", baseMultiplier = 0.6},
    {stat = "protection", amount = 2 },
    {stat = "physicalResistance", amount = 0.25},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = -1},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0}  
  })

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end

function update(dt)

end

function uninit()
  
end