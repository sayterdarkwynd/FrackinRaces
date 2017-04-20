function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "liquidnitrogenImmunity", amount = 1},
    {stat = "iceslipImmunity", amount = 1},
    {stat = "iceStatusImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.4},
    {stat = "iceResistance", amount = 0.4},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0} 
  })

    if (world.type() == "arctic") or (world.type() == "snow") or (world.type() == "arcticdark") or (world.type() == "snowdark") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 1.10},
	      {stat = "maxEnergy", baseMultiplier = 1.10}
	    })
    end  
    
  script.setUpdateDelta(0)
 
end

function update(dt)

end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end