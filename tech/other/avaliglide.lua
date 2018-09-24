require "/scripts/vec2.lua"

function init()
  initCommonParameters()
end

function initCommonParameters()
  self.energyCost = config.getParameter("energyCostPerSecond")
  self.bombTimer = 0
  self.energyCostPerSecond = config.getParameter("energyCostPerSecond")
  self.active=false
  self.available = true
  self.species = world.entitySpecies(entity.id())
  self.timer = 0  
  self.active2 = 0
  self.active3 = 0
  self.forceDeactivateTime = 3
end

function uninit()
  animator.setParticleEmitterActive("feathers", false)
  animator.stopAllSounds("activate")	
  animator.stopAllSounds("recharge")
  status.clearPersistentEffects("glide")  
  deactivate()
end

function checkFood()
	if status.isResource("food") then
		self.foodValue = status.resource("food")		
	else
		self.foodValue = 15
	end
end

function checkStance()
    if self.pressDown and self.active2 == 0 then
      animator.playSound("slowfallMode")
      animator.setSoundVolume("slowfallMode", 2,0)
      self.active2 = 1
      self.active3 = 0   
    elseif self.pressUp and self.active3 == 0 then
      animator.playSound("glideMode")
      animator.setSoundVolume("glideMode", 2,0)
      self.active2 = 0
      self.active3 = 1	        
    end 
    self.bombTimer = 1   
end


function activeFlight()
    animateFlight()
end

function animateFlight()
    animator.setParticleEmitterOffsetRegion("feathers", mcontroller.boundBox())
    animator.setParticleEmitterActive("feathers", true)	
    animator.setFlipped(mcontroller.facingDirection() < 0)   
end


function update(args)
  checkFood()
  
  if not self.specialLast and args.moves["special1"] then
    attemptActivation()
  end
  
  self.specialLast = args.moves["special1"]
  self.pressSpecial = args.moves["special1"]
  self.pressJump = args.moves["jump"]
  self.pressUp = args.moves["up"]
  self.pressDown = args.moves["down"]
  
  if not args.moves["special1"] then
    self.forceTimer = nil
  end

  if self.active and status.overConsumeResource("energy", 0.001) then
  
	    if self.bombTimer > 0 then
	      self.bombTimer = math.max(0, self.bombTimer - args.dt)
	    end
	    
	    if self.pressDown or self.pressDown and self.active2== 1 then  --slowfall stance	
	      if not mcontroller.onGround() and not mcontroller.zeroG() then
		      status.setPersistentEffects("glide", {
			{stat = "fallDamageResistance", effectiveMultiplier = 1.65},
			{stat = "gliding", amount = 0}
		      })	      
	      end
	      if self.bombTimer == 0 then
	        checkStance()
	      end
	    end
	    
	    if self.pressUp or self.pressUp and self.active3== 1 then  -- glide stance
	      if not mcontroller.onGround() and not mcontroller.zeroG() then
		      status.setPersistentEffects("glide", {
			{stat = "fallDamageResistance", effectiveMultiplier = 1.45},
			{stat = "gliding", amount = 1}
		      })  	      
	      end
	      if self.bombTimer == 0 then
	        checkStance()
	      end	      
	    end    

	  if not mcontroller.onGround() and not mcontroller.zeroG() then
		  if self.active2 == 1 then
			mcontroller.controlParameters(config.getParameter("fallingParameters1"))
			mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed1")))
		  elseif self.active3 == 1 then
			mcontroller.controlParameters(config.getParameter("fallingParameters2"))
			mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed2")))
		  end
		  if self.foodValue > 15 then
		      status.addEphemeralEffects{{effect = "foodcost", duration = 0.1}}
		  else
		      status.overConsumeResource("energy", config.getParameter("energyCostPerSecond"),1)
		  end	
		  activeFlight()    
	  end	  
	  
    checkForceDeactivate(args.dt)
  end
end

function attemptActivation()
  if not self.active then
    activate()  
  elseif self.active then
      deactivate()
    if not self.forceTimer then
      self.forceTimer = 0
    end
  end
end

function checkForceDeactivate(dt)
  if self.forceTimer then
    self.forceTimer = self.forceTimer + dt
    if self.forceTimer >= self.forceDeactivateTime then
      deactivate()
      self.forceTimer = nil
      status.clearPersistentEffects("glide")  
    else
      attemptActivation()
    end
    return true
  else
    return false
  end
end

function activate()
  if not self.active then
        animator.playSound("activate") 	
  else
        status.clearPersistentEffects("glide")      
        deactivate()
  end
  self.active = true
end

function deactivate()
  if self.active then
    status.clearPersistentEffects("glide") 
    animator.setParticleEmitterActive("feathers", false)
    animator.stopAllSounds("activate")	
    animator.stopAllSounds("recharge")    
  end
  self.active = false
end
