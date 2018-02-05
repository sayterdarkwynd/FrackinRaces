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
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.5},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.5}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.4 }) 
	elseif lightLevel <= 2 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.55},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.55}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.3 }) 	
	elseif lightLevel <= 5 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.6},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.6}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.2 }) 
	elseif lightLevel <= 7 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.7},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.7}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.1 }) 	  
	elseif lightLevel <= 8 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.8},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.8}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.0 })	
	elseif lightLevel <= 9 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.9},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.9}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.0 })	  
	elseif lightLevel <= 10 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.0},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.0}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.0 })
	else
	  status.clearPersistentEffects("webberEffects")
	end  
end

function uninit()
  status.clearPersistentEffects("webberEffects")
end
