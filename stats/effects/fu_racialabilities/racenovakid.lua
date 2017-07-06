function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")

    effect.addStatModifierGroup({
	    -- base Attributes
	    {stat = "isOmnivore", amount = 1},
	    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
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
	    {stat = "fireStatusImmunity", amount = 1},
	    {stat = "radiationburnImmunity", amount = 1},    
	    {stat = "grit", amount = 0.2}
    })

    if (world.type() == "alien") or (world.type() == "jungle")  or (world.type() == "irradiated")  or (world.type() == "chromatic") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 1.15},
	      {stat = "maxEnergy", baseMultiplier = 1.15}
	    })
    end 
    
  script.setUpdateDelta(5)
end

function update(dt)
  mcontroller.controlModifiers({
    speedModifier = 1.05
  })
end

function uninit()
    status.clearPersistentEffects("jungleEpic")
end