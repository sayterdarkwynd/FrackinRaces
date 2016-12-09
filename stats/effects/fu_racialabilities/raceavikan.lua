function init()

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "fireStatusImmunity", amount = 1},
    {stat = "biomeheatImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = 1},
    {stat = "iceResistance", amount = -1},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0} 
  })

  script.setUpdateDelta(0)

	if (world.type() == "desert") or (world.type() == "desertwastes") or (world.type() == "desertwastesdark") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "powerMultiplier", baseMultiplier = 1.10},
		      {stat = "maxHealth", baseMultiplier = 1.15}
		    })
	end  
	
end

function update(dt)

end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end