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
	  mcontroller.controlModifiers({ speedModifier = 1.3 })
	elseif lightLevel <= 2 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.5},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.5}
	  })
	  mcontroller.controlModifiers({ speedModifier = 1.25 })
  elseif lightLevel <= 3 then
    status.setPersistentEffects("webberEffects", {
    {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.55},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.55}
    })
    mcontroller.controlModifiers({ speedModifier = 1.2 })
  elseif lightLevel <= 4 then
    status.setPersistentEffects("webberEffects", {
    {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.6},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.6}
    })
    mcontroller.controlModifiers({ speedModifier = 1.15 })
	elseif lightLevel <= 5 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.65},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.65}
	  })
	  mcontroller.controlModifiers({ speedModifier = 1.13 })
  elseif lightLevel <= 6 then
    status.setPersistentEffects("webberEffects", {
    {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.7},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.7}
    })
    mcontroller.controlModifiers({ speedModifier = 1.11 })
	elseif lightLevel <= 7 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.75},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.75}
	  })
	  mcontroller.controlModifiers({ speedModifier = 1.09 })
	elseif lightLevel <= 8 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.8},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.8}
	  })
	  mcontroller.controlModifiers({ speedModifier = 1.05 })
	elseif lightLevel <= 9 then
	  status.setPersistentEffects("webberEffects", {
	  {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 0.9},
	  {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 0.9}
	  })
	  mcontroller.controlModifiers({ speedModifier = 1.0 })
	else
	  status.clearPersistentEffects("webberEffects")
	end
end

function uninit()
  status.clearPersistentEffects("webberEffects")
end
