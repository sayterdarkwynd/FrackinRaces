function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "snowslowImmunity", amount = 1},
    {stat = "iceslipImmunity", amount = 1},
    {stat = "iceStatusImmunity", amount = 1},
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.4},
    {stat = "iceResistance", amount = 0.4},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0}  
  })
 
    local bounds = mcontroller.boundBox()
    onColdWorld()
    onHotWorld()
	
	if (self.isCold)==1 then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 1.25}
	    })	
	end
	
	if (self.isHot)==1 then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 0.75}
	    })	
	end
  script.setUpdateDelta(10)
end


function onColdWorld()
  if (world.type() == "snow") or (world.type() == "arctic") or (world.type() == "arcticdark") or (world.type() == "icemoon") or (world.type() == "icewaste") or (world.type() == "icewastedark") then
    self.isCold = 1
  else
    self.isCold = 0
  end
end

function onHotWorld()
  if (world.type() == "scorchedcity") or (world.type() == "desert") or (world.type() == "desertwastes") or (world.type() == "desertwastesdark") or (world.type() == "magma") or (world.type() == "magmadark") or (world.type() == "volcanic") or (world.type() == "volcanicdark") then
    self.isHot = 1
  else
    self.isHot = 0
  end
end

function update(dt)
	if not mcontroller.onGround() then
	  if self.isHot == 1 then
		status.clearPersistentEffects("flightPower")		
	  else
	    status.setPersistentEffects("flightPower", {
	      {stat = "powerMultiplier", baseMultiplier = 1.1}
	    })	
	  end      
	end
  
	if mcontroller.falling() then
	  mcontroller.controlParameters(config.getParameter("fallingParameters"))
	  mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed")))
	end
	
	if self.isHot == 1 then
		mcontroller.controlModifiers({
		  speedModifier = 0.9,
		  airJumpModifier = 1.0
		})
	elseif self.isCold == 1 then
		mcontroller.controlModifiers({
		  speedModifier = 1.14,
		  airJumpModifier = 1.09
		})
	else	
		mcontroller.controlModifiers({
		  speedModifier = 1.09,
		  airJumpModifier = 1.09
		})	
	end
	
	if (world.windLevel(mcontroller.position()) >= 70 ) then
		mcontroller.controlModifiers({
		  speedModifier = 1.12,
		  airJumpModifier = 1.12
		})
	elseif (world.windLevel(mcontroller.position()) >= 7 ) then
		mcontroller.controlModifiers({
		  speedModifier = 1.20,
		  airJumpModifier = 1.20
		})
	end
end

function uninit()
  status.clearPersistentEffects("jungleEpic")  
end