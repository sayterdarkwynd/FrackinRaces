require "/scripts/vec2.lua"
require "/scripts/util.lua"
require "/scripts/interp.lua"

function init()
  self.energyCostPerSecond = config.getParameter("energyCostPerSecond")
  self.active=false
  self.available = true
  self.species = world.entitySpecies(entity.id())
  self.firetimer = 0
  checkFood()
end

function uninit()

end

function checkFood()
	if status.isResource("food") then
		self.foodValue = status.resource("food")		
	else
		self.foodValue = 15
	end
end

function activeFlight()
    local damageConfig = { power = (self.foodValue/50), damageSourceKind = "fire" } 
    animator.playSound("activate",3)
    animator.playSound("recharge")
    animator.setSoundVolume("activate", 0.5,0)
    animator.setSoundVolume("recharge", 0.375,0)
    world.spawnProjectile("flamethrower", mcontroller.position(), entity.id(), aimVector(), false, damageConfig)
end

function aimVector()
  local aimVector = vec2.rotate({1, 0}, sb.nrand(0, 0))
  aimVector[1] = aimVector[1] * mcontroller.facingDirection()
  return aimVector
end


function update(args)
        checkFood()
        self.firetimer = math.max(0, self.firetimer - args.dt)
	if args.moves["special1"] and status.overConsumeResource("energy", 0.001) then 
		if self.foodValue > 15 then
		    status.addEphemeralEffects{{effect = "foodcostfire", duration = 0.1}}
		else
		    status.overConsumeResource("energy", 0.7)
		end	
	   
	      if self.firetimer == 0 then
		self.firetimer = 0.1
		activeFlight()
	      end
	    	
	else
  	        animator.stopAllSounds("activate")	
	end
end

function idle()

end