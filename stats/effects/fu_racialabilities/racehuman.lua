function init()
  baseValue3 = config.getParameter("foodBonus",0)*(status.resourceMax("food"))
  
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isOmnivore", amount = 1},
    --other
    {stat = "grit", amount = 0.2}
  })


  
  


  self.movementParams = mcontroller.baseParameters()    
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
  
  
  self.liquidMovementParameter = {
    liquidJumpProfile = {
      jumpHoldTime = 0.28
    }
  }  
end


function update(dt)
  mcontroller.controlParameters(self.liquidMovementParameter)
end

function uninit()
  
end
