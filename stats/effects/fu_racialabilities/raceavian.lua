function init()
baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})
  self.powerModifier = config.getParameter("powerModifier", 0)
  effect.addStatModifierGroup({{stat = "powerMultiplier", baseMultiplier = self.powerModifier}})
  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", baseMultiplier = 0.35}})
  self.movementParams = mcontroller.baseParameters()  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
  self.liquidMovementParameter = {
    airJumpProfile = { 
      jumpSpeed = 30
    }
  }  

end

function update(dt)
mcontroller.controlParameters(self.liquidMovementParameter)
    if mcontroller.falling() then
      mcontroller.controlParameters(config.getParameter("fallingParameters"))
      mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed")))
    end
end

function uninit()
  
end


