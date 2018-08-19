require "/scripts/vec2.lua"

function init()
  self.energyCostPerSecond = config.getParameter("energyCostPerSecond")
  self.active=false
  self.available = true
  self.species = world.entitySpecies(entity.id())
  self.timer = 0
end

function uninit()
  status.clearPersistentEffects("bugarmor")
  animator.stopAllSounds("activate")
  animator.setParticleEmitterActive("bugarmor", false)
end

function checkFood()
	if status.isResource("food") then
		self.foodValue = status.resource("food")		
	else
		self.foodValue = 10
	end
end

function animateFlight()
    	animator.setParticleEmitterOffsetRegion("bugarmor", mcontroller.boundBox())
    	animator.setParticleEmitterActive("bugarmor", true)	    
end

function update(args)
        checkFood()
	if args.moves["special1"] and status.overConsumeResource("energy", 0.001) then 
	        animateFlight()
		if self.timer then
		  self.timer = math.max(0, self.timer - args.dt)
		  if self.timer == 0 then
		    animator.playSound("activate")
		    self.timer = 1
		  end
		end	
		if self.foodValue > 10 then
		      status.addEphemeralEffects{{effect = "foodcostarmor", duration = 0.1}}
		      status.setPersistentEffects("bugarmor", {
			{stat = "protection", effectiveMultiplier = 1.15},
			{stat = "maxEnergy", effectiveMultiplier = 0.70},
			{stat = "physicalResistance", baseMultiplier = 1.3}
		      })		    
		else
		    status.overConsumeResource("energy", config.getParameter("energyCostPerSecond"),0.4)
		      status.setPersistentEffects("bugarmor", {
			{stat = "protection", effectiveMultiplier = 1.15},
			{stat = "maxEnergy", effectiveMultiplier = 0.70},
			{stat = "physicalResistance", baseMultiplier = 1.3}
		      })		    
		end	
	else
  	    idle()
	end
end

function idle()
  status.clearPersistentEffects("bugarmor")
  animator.stopAllSounds("activate")
  animator.setParticleEmitterActive("bugarmor", false)
end