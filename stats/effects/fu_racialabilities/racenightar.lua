function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  baseValue3 = config.getParameter("foodBonus",0)*(status.resourceMax("food"))
  self.gritBoost = config.getParameter("gritBonus",0)
  
  effect.addStatModifierGroup({
    {stat = "grit", baseMultiplier = self.gritBoost },
    {stat = "biooozeImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0.50}
  })
  
  self.movementParams = mcontroller.baseParameters() 
  local bounds = mcontroller.boundBox()
  self.liquidMovementParameter = { liquidJumpProfile = { jumpHoldTime = 0.275 } }  
  script.setUpdateDelta(5)
end

function update(dt)


end

function uninit()

end