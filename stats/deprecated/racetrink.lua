function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")

    effect.addStatModifierGroup({
	    -- base Attributes
	    {stat = "isRobot", amount = 1},
	    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
	    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance",0)},
    {stat = "electricResistance", amount = config.getParameter("electricResistance",0)},
    {stat = "fireResistance", amount = config.getParameter("fireResistance",0)},
    {stat = "iceResistance", amount = config.getParameter("iceResistance",0)},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance",0)},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance",0)},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance",0)},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance",0)},
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
		status.setPersistentEffects("jungleEpic", {
		{stat = "energyRegenPercentageRate", baseMultiplier = 1.25},
		{stat = "foodDelta", baseMultiplier = 0.03}})
	elseif (world.type() == "desert") or (world.type() == "desertwastes") or (world.type() == "desertwastesdark") or (world.type() == "magma") or (world.type() == "magmadark") or (world.type() == "volcanic") or (world.type() == "volcanicdark") then
		status.setPersistentEffects("jungleEpic", {
		  {stat = "energyRegenPercentageRate", baseMultiplier = 0.5},
		  {stat = "foodDelta", baseMultiplier = 0.03}
		})	
	else
		status.setPersistentEffects("jungleEpic", {
		  {stat = "foodDelta", baseMultiplier = 0.03}
		})
	end  	
end

function update(dt)	
	
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end