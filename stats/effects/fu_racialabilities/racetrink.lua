function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")

    effect.addStatModifierGroup({
	    -- base Attributes
	    {stat = "isRobot", amount = 1},
	    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
	    -- resistances
	    {stat = "physicalResistance", amount = config.getParameter("physicalResistance")},
	    {stat = "electricResistance", amount = config.getParameter("electricResistance")},
	    {stat = "fireResistance", amount = config.getParameter("fireResistance")},
	    {stat = "iceResistance", amount = config.getParameter("iceResistance")},
	    {stat = "poisonResistance", amount = config.getParameter("poisonResistance")},
	    {stat = "shadowResistance", amount = config.getParameter("shadowResistance")},
	    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance")},
	    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance")},
	    --other
	    {stat = "poisonStatusImmunity", amount = 1},
	    {stat = "breathProtection", amount = 1},
	    {stat = "waterbreathProtection", amount = 1},
	    {stat = "iceStatusImmunity", amount = 1},
	    {stat = "iceslipImmunity", amount = 1},
	    {stat = "snowslowImmunity", amount = 1},
	    {stat = "slushslowImmunity", amount = 1}	    
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