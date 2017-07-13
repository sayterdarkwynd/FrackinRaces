function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")

    effect.addStatModifierGroup({
	    -- base Attributes
	    {stat = "isCarnivore", amount = 1},
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
	    {stat = "foodDelta", baseMultiplier = 0.5},   
	    {stat = "blacktarImmunity", amount = 1},
	    {stat = "jungleslowImmunity", amount = 1 }    
    })

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
  
end

function update(dt)
    mcontroller.controlModifiers({
	airJumpModifier = 1.20
    })
end

function uninit()
  
end