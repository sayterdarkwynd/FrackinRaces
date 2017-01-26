function init()

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "biomeradiationImmunity", amount = 1},
    {stat = "breathProtection", amount = 1},
    {stat = "waterbreathProtection", amount = 1},
    {stat = "ffextremeradiationImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = -0.7},
    {stat = "poisonResistance", amount = 0.8},
    {stat = "poisonStatusImmunity", amount = 1},
    {stat = "shadowResistance", amount = 0},
    {stat = "radioactiveResistance", amount = 1},
    {stat = "radiationburnImmunity", amount = 1},
    {stat = "powerMultiplier", baseMultiplier = 1.25}
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