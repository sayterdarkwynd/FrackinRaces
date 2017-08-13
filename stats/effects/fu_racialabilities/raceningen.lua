function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isOmnivore", amount = 1},
    --{stat = "maxHealth", amount = self.baseMaxHealth + config.getParameter("healthBonus")},
    --{stat = "maxEnergy", amount = self.baseMaxEnergy + config.getParameter("energyBonus")},
    --{stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    --{stat = "protection", baseMultiplier = config.getParameter("defenseBonus")},
    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance",0)},
    {stat = "electricResistance", amount = config.getParameter("electricResistance",0)},
    {stat = "fireResistance", amount = config.getParameter("fireResistance",0)},
    {stat = "iceResistance", amount = config.getParameter("iceResistance",0)},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance",0)},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance",0)},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance",0)},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance",0)},
    {stat = "grit", amount = 0.1},
    {stat = "biooozeImmunity", amount = 1}
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
