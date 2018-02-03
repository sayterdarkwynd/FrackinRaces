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
	if lightLevel <= 22 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.4},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.4}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.7 }) 
	elseif lightLevel <= 24 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.5},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.5}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.5 }) 	
	elseif lightLevel <= 26 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.55},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.55}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.4 }) 
	elseif lightLevel <= 28 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.6},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.6}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.2 }) 	  
	elseif lightLevel <= 30 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.65},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.7}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.2 })	
	elseif lightLevel <= 35 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.70},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.72}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.2 })	  
	elseif lightLevel <= 40 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.75},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.75}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 1.2 })
	else
	  status.clearPersistentEffects("webberEffects")
	end  
end

function uninit()
  status.clearPersistentEffects("webberEffects")
end
