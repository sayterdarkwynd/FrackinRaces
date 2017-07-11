function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    {stat = "isCarnivore", amount = 1},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance")},
    {stat = "electricResistance", amount = config.getParameter("electricResistance")},
    {stat = "fireResistance", amount = config.getParameter("fireResistance")},
    {stat = "iceResistance", amount = config.getParameter("iceResistance")},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance")},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance")},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance")},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance")},
    {stat = "energyRegenBlockTime", baseMultiplier = 0.8}
  })

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.15,
			airJumpModifier = 1.10
		})
end

function uninit()
  
end