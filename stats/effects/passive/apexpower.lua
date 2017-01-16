function init()
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
  local foodValue = status.resource("food")
end

function update(dt)

if self.foodValue == nil then 
  foodValue=1 
end


if self.foodValue == nil then 
  foodValue=1 
end

self.foodValue = status.resource("food")

local foodMax = 100
local foodMin = 35
local foodRange = foodMax - foodMin
local ratio = math.max(0, (status.resource("food") - foodMin) / foodRange)

local energyMax = 1.5
local energyMin = 1
local energyRange = energyMax - energyMin
local finalEnergy = math.floor((energyMin + energyRange * ratio) * 100) / 100

if self.foodValue > foodMin then
  status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = finalEnergy}})
end


  if self.foodValue < 5 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", baseMultiplier = 1.20},
      {stat = "grit", baseMultiplier = 1.50},
      {stat = "maxEnergy", baseMultiplier = 0.5}
    })
  elseif self.foodValue < 10 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", baseMultiplier = 1.175},
      {stat = "grit", baseMultiplier = 1.45},
      {stat = "maxEnergy", baseMultiplier = 0.45}
    })
  elseif self.foodValue < 20 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", baseMultiplier = 1.15},
      {stat = "grit", baseMultiplier = 1.40},
      {stat = "maxEnergy", baseMultiplier = 0.4}
    }) 
  elseif self.foodValue < 30 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", baseMultiplier = 1.125},
      {stat = "grit", baseMultiplier = 1.35},
      {stat = "maxEnergy", baseMultiplier = 0.35}
    })
  elseif self.foodValue < 40 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", baseMultiplier = 1.10},
      {stat = "grit", baseMultiplier = 1.30},
      {stat = "maxEnergy", baseMultiplier = 0.30}
    })   
  elseif self.foodValue < 50 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", baseMultiplier = 1.08},
      {stat = "grit", baseMultiplier = 1.20},
      {stat = "maxEnergy", baseMultiplier = 0.25}
    })
  elseif self.foodValue < 60 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", baseMultiplier = 1.05},
      {stat = "grit", baseMultiplier = 1.10},
      {stat = "maxEnergy", baseMultiplier = 0.10}
    })
  else
    status.clearPersistentEffects("starvationpower")
  end

	  
end

function uninit()
  status.clearPersistentEffects("starvationpower")
  status.clearPersistentEffects("starvationpower2")
end











