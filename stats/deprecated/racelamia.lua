function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")

    effect.addStatModifierGroup({
	    -- base Attributes
	    {stat = "isCarnivore", amount = 1},
	    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
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