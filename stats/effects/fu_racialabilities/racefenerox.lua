function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isCarnivore", amount = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    --{stat = "protection", baseMultiplier = config.getParameter("defenseBonus")},
    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance")},
    {stat = "electricResistance", amount = config.getParameter("electricResistance")},
    {stat = "fireResistance", amount = config.getParameter("fireResistance")},
    {stat = "iceResistance", amount = config.getParameter("iceResistance")},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance")},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance")},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance")},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance")},
    {stat = "foodDelta", baseMultiplier = 1.06346}
  })

  script.setUpdateDelta(10)
  
    if (world.type() == "savannah") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "powerMultiplier", baseMultiplier = 1.15}
	    })
    end     
end

function update(dt)
		mcontroller.controlModifiers({
				speedModifier = 1.06,
				airJumpModifier = 1.11
			})
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end