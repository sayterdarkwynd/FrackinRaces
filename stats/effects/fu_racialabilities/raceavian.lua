function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isOmnivore", baseMultiplier = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    --{stat = "protection", baseMultiplier = config.getParameter("defenseBonus")},
    {stat = "fallDamageMultiplier", baseMultiplier = config.getParameter("fallBonus")},
    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance")},
    {stat = "electricResistance", amount = config.getParameter("electricResistance")},
    {stat = "fireResistance", amount = config.getParameter("fireResistance")},
    {stat = "iceResistance", amount = config.getParameter("iceResistance")},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance")},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance")},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance")},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance")}
  })
  
  self.movementParams = mcontroller.baseParameters()  
  self.liquidMovementParameter = {
    airJumpProfile = { 
      jumpSpeed = 30
    }
  }  
  script.setUpdateDelta(5)
end

function update(dt)
        mcontroller.controlParameters(self.liquidMovementParameter)
        
        if not mcontroller.onGround() then
	    status.setPersistentEffects("avianflightpower", {
	      {stat = "powerMultiplier", baseMultiplier = 1.12}
	    }) 
	else
	    status.clearPersistentEffects("avianflightpower")
        end
        
	if mcontroller.falling() then
	  mcontroller.controlParameters(config.getParameter("fallingParameters"))
	  mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed")))
	end
	
	
	
	if (world.windLevel(mcontroller.position()) >= 60 ) then
	    maxFallSpeed = -30
	    status.clearPersistentEffects("avianwindbonus")
	elseif (world.windLevel(mcontroller.position()) >= 5 ) then
	    maxFallSpeed = -32
	    status.setPersistentEffects("avianwindbonus", {
	      {stat = "protection", baseMultiplier = 1.10},
	      {stat = "maxHealth", baseMultiplier = 1.15}
	    })
		mcontroller.controlModifiers({
		  speedModifier = 1.19,
		  airJumpModifier = 1.20,
		  airForce = 86
		})	
	end
end

function uninit()
  status.clearPersistentEffects("avianwindbonus")
  status.clearPersistentEffects("avianflightpower")
end


