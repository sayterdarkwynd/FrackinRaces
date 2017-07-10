function init()

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "isRobot", amount = 1 },
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "iceStatusImmunity", amount = 1},
    {stat = "iceslipImmunity", amount = 1},
    {stat = "snowslowImmunity", amount = 1},
    {stat = "slushslowImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0.1},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0.6},
    {stat = "electricResistance", amount = -1},
    {stat = "radioactiveResistance", amount = 0.5},
    {stat = "poisonResistance", amount = 0.5},
    {stat = "poisonStatusImmunity", amount = 1},
    {stat = "breathProtection", amount = 1},
    {stat = "waterbreathProtection", amount = 1},
    {stat = "shadowResistance", amount = 0}
  })

  script.setUpdateDelta(0)
	if (world.type() == "snow") or (world.type() == "tundra") or (world.type() == "arctic") or (world.type() == "nitrogensea") or (world.type() == "icemoon") or (world.type() == "frozenvolcanic") or (world.type() == "icewastes") then
		status.setPersistentEffects("jungleEpic", {{stat = "energyRegenPercentageRate", baseMultiplier = 1.25},{stat = "foodDelta", baseMultiplier = 0.03}})
	else
		status.setPersistentEffects("jungleEpic", {{stat = "foodDelta", baseMultiplier = 0.03}})
	end  	
end

function update(dt)	
	
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end