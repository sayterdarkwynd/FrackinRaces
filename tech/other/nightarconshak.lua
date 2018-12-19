require "/scripts/vec2.lua"

function init()
  initCommonParameters()
end

function initCommonParameters()
  self.energyCost = config.getParameter("energyCostPerSecond")
  self.bombTimer = 0
  self.conshakTimer = 0
end

function uninit()
  deactivate()
end


function checkStance()

    if (self.conshakTimer < 500) then
    	animator.setParticleEmitterActive("conshak", false)
    else
      animator.playSound("conshakActivate")
    end
    
    if self.pressDown then    
       animator.setParticleEmitterActive("defenseStance", true)
       animator.playSound("conshakCharge")
    else
      animator.setParticleEmitterActive("defenseStance", false)
      status.clearPersistentEffects("nightarconshak") 
    end 
    self.bombTimer = 10  
end

function update(args)

  if not self.specialLast and args.moves["special1"] then
    attemptActivation()
  end
  
  self.specialLast = args.moves["special1"]
  self.pressDown = args.moves["down"]
  self.pressLeft = args.moves["left"]
  self.pressRight = args.moves["right"]
  self.pressUp = args.moves["up"]
  self.pressJump = args.moves["jump"]
  
  if not args.moves["special1"] then
    self.forceTimer = nil
  end

  if self.active then
    if self.bombTimer > 0 then
      self.bombTimer = math.max(0, self.bombTimer - args.dt)
    end
    if (self.pressDown) and not self.pressLeft and not self.pressRight and not self.pressUp and not self.pressJump then
      
      if (self.conshakTimer < 500) then
        self.conshakTimer = self.conshakTimer + 1
        sb.logInfo(self.conshakTimer)      
      else
        self.conshakTimer = 0
      end

      
      status.setPersistentEffects("nightarconshak", {
	{stat = "protection", effectiveMultiplier = 0.5},
	{stat = "powerMultiplier", effectiveMultiplier = 0.5},
	{stat = "maxEnergy", effectiveMultiplier = 0.5},
	{stat = "breathDepletionRate", effectiveMultiplier = 0.25},
	{stat = "breathRegenerationRate", effectiveMultiplier = 1.25},
	{stat = "foodDelta", effectiveMultiplier = 0.25}
      })
      animator.setParticleEmitterActive("defenseStance", true)
      if self.bombTimer == 0 then
	checkStance()
      end
      
      if (self.conshakTimer >= 500) then
        animator.setParticleEmitterActive("defenseStance", false)
        animator.setParticleEmitterActive("conshak", true)
        local configBombDrop = { power = 0 }
        world.spawnProjectile("activeConshakCharged", mcontroller.position(), entity.id(), {0, 0}, false, configBombDrop)    
        status.addEphemeralEffects{{effect = "defense6", duration = 30}}
        status.addEphemeralEffects{{effect = "physicalblock3", duration = 30}}
        self.conshakTimer = 0
      end
      
    else
      animator.setParticleEmitterActive("defenseStance", false)
      animator.setParticleEmitterActive("conshak", false)
      status.clearPersistentEffects("nightarconshak") 
    end   
    
    checkForceDeactivate(args.dt)
  end
end

function attemptActivation()
  if not self.active then
    activate()
    local configBombDrop = { power = 0 }
    world.spawnProjectile("activeConshak", mcontroller.position(), entity.id(), {0, 0}, false, configBombDrop)    
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
      status.clearPersistentEffects("nightarconshak")   
      self.conshakTimer = 0
    else
      attemptActivation()
    end
    return true
  else
    return false
  end
end

function activate()
	status.clearPersistentEffects("nightarconshak")   
	self.active = true
end

function deactivate()
	if self.active then
	  status.clearPersistentEffects("nightarconshak")  
	end
	self.conshakTimer = 0
	self.active = false
end
