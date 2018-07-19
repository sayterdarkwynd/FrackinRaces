function init()
  local bounds = mcontroller.boundBox()
  self.powerBonus = 0.1
  script.setUpdateDelta(10)
end

function getLight()
  local position = mcontroller.position()
  position[1] = math.floor(position[1])
  position[2] = math.floor(position[2])
  local lightLevel = world.lightLevel(position)
  lightLevel = math.floor(lightLevel * 100)
  return lightLevel
end

function update(dt)
  local lightLevel = getLight()
	if lightLevel >= 95 then
	  status.setPersistentEffects("gardevanEffects", {
	  {stat = "energyRegenPercentageRate", amount = 1.08 + config.getParameter("powerBonus",0)},
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.08},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.08}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.20 }) 
	elseif lightLevel >= 80 then
	  status.setPersistentEffects("gardevanEffects", {
	  {stat = "energyRegenPercentageRate", amount = 1.08 + config.getParameter("powerBonus",0)},
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.07},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.07}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.18 }) 	
	elseif lightLevel >= 70 then
	  status.setPersistentEffects("gardevanEffects", {
	  {stat = "energyRegenPercentageRate", amount = 1.08 + config.getParameter("powerBonus",0)},
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.06},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.06}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.16 }) 
	elseif lightLevel >= 60 then
	  status.setPersistentEffects("gardevanEffects", {
	  {stat = "energyRegenPercentageRate", amount = 1.08 + config.getParameter("powerBonus",0)},
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.05},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.05}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.14 }) 	  
	elseif lightLevel >= 50 then
	  status.setPersistentEffects("gardevanEffects", {
	  {stat = "energyRegenPercentageRate", amount = 1.08 + config.getParameter("powerBonus",0)},
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.04},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.04}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.11 })	
	elseif lightLevel >= 40 then
	  status.setPersistentEffects("gardevanEffects", {
	  {stat = "energyRegenPercentageRate", amount = 1.08 + config.getParameter("powerBonus",0)},
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.02},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.02}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.09 })	  
	elseif lightLevel >= 30 then
	  status.setPersistentEffects("gardevanEffects", {
	  {stat = "energyRegenPercentageRate", amount = 1.08 + config.getParameter("powerBonus",0)},
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.00},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.00}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.06 })
	else 
	    status.clearPersistentEffects("gardevanEffects")
	end  
end

function uninit()
  
end