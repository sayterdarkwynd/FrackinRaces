function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "biooozeImmunity", amount = 1 },
    {stat = "insanityImmunity", amount = 1 },
    {stat = "foodDelta", baseMultiplier = 0.7},
    {stat = "physicalResistance", amount = 1.15},
    {stat = "fireResistance", amount = 1},
    {stat = "iceResistance", amount = -1.75},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = 1}
  })
  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)

end

function update(dt)

end

function uninit()
  
end