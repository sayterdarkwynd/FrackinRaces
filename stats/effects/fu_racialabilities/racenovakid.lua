function init()
  self.gritBoost = config.getParameter("gritBonus",0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "grit", amount = self.gritBoost },
    {stat = "fireStatusImmunity", amount = 1},
    {stat = "physicalResistance", amount = -0.1},
    {stat = "fireResistance", amount = 0.25},
    {stat = "iceResistance", amount = -0.25},
    {stat = "electricResistance", amount = -0.15},
    {stat = "poisonResistance", amount = 0.20},
    {stat = "shadowResistance", amount = -0.5},
    {stat = "radioactiveResistance", amount = 0.35}
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