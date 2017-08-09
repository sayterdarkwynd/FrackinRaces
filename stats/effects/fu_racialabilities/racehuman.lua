function init()
  baseValue3 = config.getParameter("foodBonus",0)*(status.resourceMax("food"))
  
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isOmnivore", amount = 1},
    --other
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance",0)},
    {stat = "electricResistance", amount = config.getParameter("electricResistance",0)},
    {stat = "fireResistance", amount = config.getParameter("fireResistance",0)},
    {stat = "iceResistance", amount = config.getParameter("iceResistance",0)},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance",0)},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance",0)},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance",0)},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance",0)},    
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
