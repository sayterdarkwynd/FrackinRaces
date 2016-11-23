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
	
	mcontroller.controlModifiers({
	  speedModifier = 1.09,
	  airJumpModifier = 1.05,
	  airForce = 56
	})	
	
	if (world.windLevel(mcontroller.position()) >= 60 ) then
	    maxFallSpeed = -39
	    status.clearPersistentEffects("avianwindbonus")
	elseif (world.windLevel(mcontroller.position()) >= 20 ) then
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
end


