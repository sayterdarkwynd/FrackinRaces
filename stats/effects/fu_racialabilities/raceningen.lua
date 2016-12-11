function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  baseValue3 = config.getParameter("foodBonus",0)*(status.resourceMax("food"))
  self.gritBoost = config.getParameter("gritBonus",0)
  
  effect.addStatModifierGroup({
    {stat = "maxFood", amount = baseValue3 },
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "shieldRegen", baseMultiplier = self.gritBoost },
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0} 
  })

  self.movementParams = mcontroller.baseParameters()
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
  
  self.liquidMovementParameter = {
    liquidJumpProfile = {
      jumpHoldTime = 0.275
    }
  }  
end


function update(dt)
  mcontroller.controlParameters(self.liquidMovementParameter)
end

function uninit()
  
end
