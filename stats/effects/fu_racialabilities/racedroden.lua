function init()

  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isRobot", amount = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance",0)},
    {stat = "electricResistance", amount = config.getParameter("electricResistance",0)},
    {stat = "fireResistance", amount = config.getParameter("fireResistance",0)},
    {stat = "iceResistance", amount = config.getParameter("iceResistance",0)},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance",0)},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance",0)},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance",0)},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance",0)},
    {stat = "breathProtection", amount = 1},
    {stat = "foodDelta", baseMultiplier = 0.00003},
    {stat = "poisonStatusImmunity", amount = 1}
  })

  script.setUpdateDelta(6)
	
end

function update(dt)	
	mcontroller.controlModifiers({
	  speedModifier = 1.1
	})	
end

function uninit()

end