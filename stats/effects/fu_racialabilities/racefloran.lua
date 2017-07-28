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
    --other
    {stat = "electricStatusImmunity", amount = 1}
  })

    if (world.type() == "thickjungle") or (world.type() == "forest") or (world.type() == "jungle") or (world.type() == "bog") or (world.type() == "arboreal") or (world.type() == "arborealdark") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 1.10},
	      {stat = "maxEnergy", baseMultiplier = 1.10}
	    })
    end   
end

function update(dt)

end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end