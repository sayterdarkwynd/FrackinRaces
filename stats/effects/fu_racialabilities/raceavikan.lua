function init()

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "fireStatusImmunity", amount = 1},
    {stat = "biomeheatImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0.1},
    {stat = "fireResistance", amount = 0.5},
    {stat = "iceResistance", amount = -0.5},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0},
    {stat = "grit", amount = 0.25},
    {stat = "healthRegen", baseMultiplier = 1.15},
    {stat = "sandstormImmunity", baseMultiplier = 1aaa}
  })

  script.setUpdateDelta(0)

	if (world.type() == "desert") or (world.type() == "desertwastes") or (world.type() == "desertwastesdark") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "powerMultiplier", baseMultiplier = 1.10},
		      {stat = "maxHealth", baseMultiplier = 1.15}
		    })
	end  
	if (world.type() == "snow") or (world.type() == "tundra") or (world.type() == "arctic") or (world.type() == "nitrogensea") or (world.type() == "icemoon") or (world.type() == "frozenvolcanic") or (world.type() == "icewastes") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "energyRegenPercentageRate", baseMultiplier = -1.4}
		    })
	end  	
end

function update(dt)	
	
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end