function init()
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
  local foodvalue = status.resource("food")
end

function update(dt)

if self.foodvalue == nil then 
foodvalue=1 
end

  self.foodvalue = status.resource("food")

  if self.foodvalue > 50 then
   self.healingRate = 1.0005 / config.getParameter("healTime", 140)
   status.modifyResourcePercentage("health", self.healingRate * dt)
  elseif self.foodvalue > 60 then
   self.healingRate = 1.0009 / config.getParameter("healTime", 140)
   status.modifyResourcePercentage("health", self.healingRate * dt)
  elseif self.foodvalue > 70 then
   self.healingRate = 1.001 / config.getParameter("healTime", 140)
   status.modifyResourcePercentage("health", self.healingRate * dt)    
  end

end

function uninit()

end


























function init()
  local bounds = mcontroller.boundBox()
  self.healingRate = 1.01 / config.getParameter("healTime", 320)
  script.setUpdateDelta(5)
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
 if lightLevel > 95 then
   self.healingRate = 1.01 / config.getParameter("healTime", 140)
   status.modifyResourcePercentage("health", self.healingRate * dt)
  elseif lightLevel > 90 then
   self.healingRate = 1.008 / config.getParameter("healTime", 180)
   status.modifyResourcePercentage("health", self.healingRate * dt)
  elseif lightLevel > 80 then
   self.healingRate = 1.007 / config.getParameter("healTime", 220)
   status.modifyResourcePercentage("health", self.healingRate * dt)
  elseif lightLevel > 70 then
   self.healingRate = 1.006 / config.getParameter("healTime", 220)
   status.modifyResourcePercentage("health", self.healingRate * dt)
  elseif lightLevel > 65 then
   self.healingRate = 1.005 / config.getParameter("healTime", 220)
   status.modifyResourcePercentage("health", self.healingRate * dt)
  elseif lightLevel > 55 then
   self.healingRate = 1.004 / config.getParameter("healTime", 240)
   status.modifyResourcePercentage("health", self.healingRate * dt)
  elseif lightLevel > 45 then
   self.healingRate = 1.003 / config.getParameter("healTime", 260)
   status.modifyResourcePercentage("health", self.healingRate * dt)
  elseif lightLevel > 35 then
   self.healingRate = 1.002 / config.getParameter("healTime", 280)
   status.modifyResourcePercentage("health", self.healingRate * dt)
  elseif lightLevel > 25 then
   self.healingRate = 1.001 / config.getParameter("healTime", 320)
   status.modifyResourcePercentage("health", self.healingRate * dt)
end  

end

function uninit()

end







