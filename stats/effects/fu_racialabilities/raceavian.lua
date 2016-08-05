function init()
  self.powerModifier = config.getParameter("powerModifier", 0)
  effect.addStatModifierGroup({{stat = "powerMultiplier", baseMultiplier = self.powerModifier}})
  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", effectiveMultiplier = 0.35}})
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

end

function uninit()
  
end


