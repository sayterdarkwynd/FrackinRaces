function init()
  self.gritBoost = config.getParameter("gritBonus",0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "grit", baseMultiplier = self.gritBoost },
    {stat = "biomeradiationImmunity", amount = 1},
    {stat = "ffextremeradiationImmunity", amount = 1},
    {stat = "fireStatusImmunity", amount = 1},
    {stat = "physicalResistance", amount = -1.1},
    {stat = "fireResistance", amount = 1.25},
    {stat = "iceResistance", amount = 1},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = -2}
  })

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
end

function update(dt)
		mcontroller.controlModifiers({
			   speedModifier = 1.085
			})
end

function uninit()

end