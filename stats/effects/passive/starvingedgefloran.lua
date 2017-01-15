function init()
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
  local foodvalue = status.resource("food")
end

function update(dt)

if self.foodvalue == nil then 
  foodvalue=1 
end

  self.foodValue = status.resource("food")
local foodMax = 100
local foodMin = 35
local foodRange = foodMax - foodMin

local ratio = math.max(0, (self.foodValue - foodMin) / foodRange)

local energyMax = 1.3
local energyMin = 1
local energyRange = energyMax - energyMin

local finalEnergy = math.floor((energyMin + energyRange * ratio) * 100) / 100

if self.foodValue > 0 then
  status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = finalEnergy}})
end

if self.foodValue < 100 then
  status.setPersistentEffects("starvationpower", {{stat = "powerMutiplier", baseMultiplier = finalEnergy}})
end
	  
end

function uninit()
  status.clearPersistentEffects("starvationpower")
  status.clearPersistentEffects("starvationpower2")
end









