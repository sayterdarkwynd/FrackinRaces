function init()

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "maxBreath", amount = 200.0},
    {stat = "biooozeImmunity", amount = 1},
    {stat = "webstickimmunity", amount = 1},
    {stat = "spiderwebImmunity", amount = 1},
    {stat = "blacktarImmunity", amount = 1},
    {stat = "physicalResistance", amount = 1},
    {stat = "fireResistance", amount = 1},
    {stat = "iceResistance", amount = 1},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = 1.25} 
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