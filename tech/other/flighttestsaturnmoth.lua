require "/scripts/vec2.lua"

function init()
  self.energyCostPerSecond = config.getParameter("energyCostPerSecond")
  self.active=false
  self.available = true
  self.species = world.entitySpecies(entity.id())
  self.timer = 0
  self.boostSpeed = 8
  self.active=false
  self.available = true
  self.forceDeactivateTime = 3
end

function uninit()
  animator.stopAllSounds("activate")	
  status.clearPersistentEffects("glide")
  animator.setParticleEmitterActive("feathers", false)
end

function checkFood()
  if status.isResource("food") then
    self.foodValue = status.resource("food")		
  else
    self.foodValue = 15
  end
end

function boost(direction)
  self.boostVelocity = vec2.mul(vec2.norm(direction), self.boostSpeed)	
  if self.boostSpeed > 20 then  -- prevent super-rapid movement
    self.boostSpeed = 20
  end    
end

function update(args)
  if not self.specialLast and args.moves["special1"] then   --toggle on
    attemptActivation() 
  end

  self.specialLast = args.moves["special1"]

  if not args.moves["special1"] then 
    self.forceTimer = nil 
  end

  if status.resource("energy") < 1 then 
    deactivate()
  end
  
  if self.active and status.overConsumeResource("energy", 0.0001) and not mcontroller.zeroG() and not mcontroller.liquidMovement() then -- do we have energy and the ability is active?
    checkFood()
    status.addEphemeralEffects{{effect = "mothflight", duration = 2}}
    
    self.upVal = args.moves["up"]  --set core movement variables
    self.downVal = args.moves["down"]
    self.leftVal = args.moves["right"]
    self.rightVal = args.moves["left"]
    self.runVal = args.moves["run"]
    
    --enable air physics
    mcontroller.controlParameters(config.getParameter("fallingParameters"))
    mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed")))  

    -- boost in direction pressed
    local direction = {0, 0} -- set default
    if self.upVal then direction[2] = direction[2] + 1 end     
    if self.downVal then direction[2] = direction[2] - 1 end                    
    if self.leftVal then direction[1] = direction[1] + 1 end  
    if self.rightVal then direction[1] = direction[1] - 1 end 
    
    self.boostSpeed = self.boostSpeed + args.dt
    boost(direction) 
    if vec2.eq(direction, {0, 0}) then 
      direction = {0, 0} 		    
    end
    mcontroller.controlApproachVelocity(self.boostVelocity, 30)
    -- end boost

    if self.foodValue > 15 then
	    if self.runVal and not self.downVal and not self.leftVal and not self.rightVal and not self.upVal then
		    status.setPersistentEffects("glide", {
		      {stat = "gliding", amount = 1},
		      {stat = "fallDamageResistance", effectiveMultiplier = 1.65}
		    })     
	    else
		    status.setPersistentEffects("glide", {
		      {stat = "gliding", amount = 0},
		      {stat = "foodDelta", amount = -5}, 
		      {stat = "fallDamageResistance", effectiveMultiplier = 1.65}
		    })     
	    end
    else
	    if self.runVal and not self.downVal and not self.leftVal and not self.rightVal and not self.upVal then
	            status.overConsumeResource("energy", 0.008)
	            status.setPersistentEffects("glide", {
		      {stat = "fallDamageResistance", effectiveMultiplier = 1.65}
		    })     
	    else
	            status.overConsumeResource("energy", 0.65)
		    status.setPersistentEffects("glide", {
		      {stat = "fallDamageResistance", effectiveMultiplier = 1.65}
		    })     
	    end  
	    
    end    
    checkForceDeactivate(args.dt)  -- force deactivation
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
  end
  self.active = true
end

function deactivate()
  if self.active then
    status.clearPersistentEffects("glide") 
    animator.setParticleEmitterActive("feathers", false)
    self.boostSpeed = 8
    status.addEphemeralEffects{{effect = "nofalldamage", duration = 2}}
  end
  self.active = false  
end