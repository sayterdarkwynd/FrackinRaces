function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isHerbivore", baseMultiplier = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    --{stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    {stat = "protection", baseMultiplier = config.getParameter("defenseBonus")},
    --{stat = "fallDamageMultiplier", baseMultiplier = config.getParameter("fallBonus")},
    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance")},
    {stat = "electricResistance", amount = config.getParameter("electricResistance")},
    {stat = "fireResistance", amount = config.getParameter("fireResistance")},
    {stat = "iceResistance", amount = config.getParameter("iceResistance")},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance")},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance")},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance")},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance")},
    {stat = "maxBreath", amount = 200},
    {stat = "foodDelta", baseMultiplier = 0.8},
    {stat = "webstickimmunity", amount = 1},
    {stat = "blacktarImmunity", amount = 1},
  })

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
	   speedModifier = 1.05
	})
end

function uninit()
  
end