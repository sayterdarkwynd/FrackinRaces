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
	if lightLevel <= 1 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.10},
	  {stat = "maxEnergy", baseMultiplier = config.getParameter("powerBonus",0) + 1.10},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.07}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.16 }) 
	elseif lightLevel <= 3 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.08},
	  {stat = "maxEnergy", baseMultiplier = config.getParameter("powerBonus",0) + 1.08},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.06}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.15 }) 	
	elseif lightLevel <= 5 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.07},
	  {stat = "maxEnergyh", baseMultiplier = config.getParameter("powerBonus",0) + 1.07},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.05}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.14 }) 
	elseif lightLevel <= 8 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.06},
	  {stat = "maxEnergy", baseMultiplier = config.getParameter("powerBonus",0) + 1.06},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.04}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.12 }) 	  
	elseif lightLevel <= 10 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.05},
	  {stat = "maxEnergy", baseMultiplier = config.getParameter("powerBonus",0) + 1.05},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.02}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.09 })	
	elseif lightLevel <= 15 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.04},
	  {stat = "maxEnergy", baseMultiplier = config.getParameter("powerBonus",0) + 1.04},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.01}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.06 })	  
	elseif lightLevel <= 25 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.02},
	  {stat = "maxEnergy", baseMultiplier = config.getParameter("powerBonus",0) + 1.02},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.00}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.04 })
	else
	  status.clearPersistentEffects("feneroxEffects")
	end  
end

function uninit()
  status.clearPersistentEffects("feneroxEffects")
end