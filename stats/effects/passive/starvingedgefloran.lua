function init()
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
  local foodValue = status.resource("food")
end

function update(dt)

if self.foodValue == nil then 
  foodValue=1 
end


self.foodValue = status.resource("food")
  if status.isResource("food") then
      self.foodValue = status.resource("food")
  else
      self.foodValue = 50
  end
  
local foodMax = 100
local foodMin = 35
local foodRange = foodMax - foodMin
local ratio = math.max(0, (status.resource("food") - foodMin) / foodRange)

local energyMax = 1.3
local energyMin = 1
local energyRange = energyMax - energyMin
local finalEnergy = math.floor((energyMin + energyRange * ratio) * 100) / 100

if self.foodValue > foodMin then
  status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = finalEnergy}})
end

  
  if self.foodValue < 5 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.24}})
  elseif self.foodValue < 10 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.20}})
  elseif self.foodValue < 20 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.15}}) 
  elseif self.foodValue < 30 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.09}})  
  elseif self.foodValue < 40 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.07}})    
  elseif self.foodValue < 50 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.05}}) 
  elseif self.foodValue < 60 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.03}}) 
  else
    status.clearPersistentEffects("starvationpower")
  end

	  
end

function uninit()
  status.clearPersistentEffects("starvationpower")
  status.clearPersistentEffects("starvationpower2")
end











