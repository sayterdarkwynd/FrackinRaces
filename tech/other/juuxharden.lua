require "/scripts/vec2.lua"

function init()
  initCommonParameters()
end

function initCommonParameters()
  self.energyCost = config.getParameter("energyCostPerSecond")
  self.juuxBonus = status.stat("juuxBonus") or 0
  self.juuxHardenTimer = 0
end

function uninit()
  deactivate()
end

function checkStance()
    animator.playSound("xibulbActivate")
    if self.pressDown then    
       animator.playSound("xibulbCharge")
    else
      status.clearPersistentEffects("juuxHarden") 
    end 
end

function update(args)
  if not self.specialLast and args.moves["special1"] then
    --attemptActivation()
    animator.playSound("activate")
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
	  if status.resource("energy") > 1 then
	    if (self.pressDown) and not self.pressLeft and not self.pressRight and not self.pressUp and not self.pressJump then 
		status.overConsumeResource("energy", config.getParameter("energyCostPerSecond"),0.1)
		status.addEphemeralEffects{{effect = "juuxhardenstat", duration = 0.1}}
	    end   
	    
	    else
	        status.clearPersistentEffects("juuxHarden")
	        self.bonus = 0	    
	  end
 		 checkForceDeactivate(args.dt)


end


function checkForceDeactivate(dt)
  if self.forceTimer then
    self.forceTimer = self.forceTimer + dt
    if self.forceTimer >= self.forceDeactivateTime then
      deactivate()
      self.forceTimer = nil
      status.removeEphemeralEffect("juuxhardenstance")  
    end
    return true
  else
    return false
  end
end

function activate()
	status.removeEphemeralEffect("juuxhardenstance")     
end

function deactivate()
	status.removeEphemeralEffect("juuxhardenstance")   
	self.active = false
end
