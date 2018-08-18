require "/scripts/vec2.lua"

function init()
  self.energyCostPerSecond = config.getParameter("energyCostPerSecond")
  self.active=false
  self.available = true
end

function uninit()

end

function update(args)

	if status.isResource("food") then
		self.foodValue = status.resource("food")
	else
		self.foodValue = 15
	end
	
	
	if args.moves["special1"] and not mcontroller.onGround() and not mcontroller.zeroG() then 
	    if config.getParameter("removesFallDamage",0) == 1 then
	        status.addEphemeralEffects{{effect = "nofalldamage", duration = 0.15}}
	    end
	    
	    if self.foodValue > 15 then 
	        status.addEphemeralEffects{{effect = "foodcost", duration = 0.15}}
	    else
                status.overConsumeResource("energy", config.getParameter("energyCostPerSecond"),1)
	    end
	    
      	    mcontroller.controlParameters(config.getParameter("fallingParameters"))
      	    mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed")))	    
	end
  	animator.setParticleEmitterOffsetRegion("feathers", mcontroller.boundBox())
  	animator.setParticleEmitterActive("feathers", true)	
	animator.setFlipped(mcontroller.facingDirection() < 0)
end

function idle()

end