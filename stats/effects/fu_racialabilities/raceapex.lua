function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({
    {stat = "fumudslowImmunity", amount = 1 },
    {stat = "jungleslowImmunity", amount = 1 },
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0.25},
    {stat = "electricResistance", amount = -0.75},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0}  
  })


if (world.type() == "jungle") or (world.type() == "thickjungle") or (world.type() == "alien") or (world.type() == "protoworld") or (world.type() == "arboreal") or (world.type() == "arborealdark") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "protection", baseMultiplier = 1.10},
	      {stat = "maxHealth", baseMultiplier = 1.15}
	    })
end  
  local foodValue = status.resource("food")

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
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

local energyMax = 1.7
local energyMin = 1
local energyRange = energyMax - energyMin
local finalEnergy = math.floor((energyMin + energyRange * ratio) * 100) / 100

if self.foodValue > foodMin then
  status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = finalEnergy}})
end

  if self.foodValue < 3.5 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", amount = 0.35},
      {stat = "grit", baseMultiplier = 1.50},
      {stat = "maxHealth", baseMultiplier = 1.25},
      {stat = "maxEnergy", baseMultiplier = 0.5}
    })
  elseif self.foodValue < 5 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", amount = 0.30},
      {stat = "grit", baseMultiplier = 1.45},
      {stat = "maxHealth", baseMultiplier = 1.20},
      {stat = "maxEnergy", baseMultiplier = 0.55}
    })
  elseif self.foodValue < 15 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", amount = 0.25},
      {stat = "grit", baseMultiplier = 1.40},
      {stat = "maxHealth", baseMultiplier = 1.175},
      {stat = "maxEnergy", baseMultiplier = 0.60}
    }) 
  elseif self.foodValue < 20 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", amount = 0.20},
      {stat = "grit", baseMultiplier = 1.35},
      {stat = "maxHealth", baseMultiplier = 1.12},
      {stat = "maxEnergy", baseMultiplier = 0.65}
    })
  elseif self.foodValue < 25 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", amount = 0.10},
      {stat = "grit", baseMultiplier = 1.30},
      {stat = "maxHealth", baseMultiplier = 1.10},
      {stat = "maxEnergy", baseMultiplier = 0.7}
    })   
  elseif self.foodValue < 30 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", amount = 0.075},
      {stat = "grit", baseMultiplier = 1.20},
      {stat = "maxHealth", baseMultiplier = 1.05},
      {stat = "maxEnergy", baseMultiplier = 0.8}
    })
  elseif self.foodValue <= 35 then
    status.setPersistentEffects("starvationpower", {
      {stat = "physicalResistance", amount = 0.05},
      {stat = "grit", baseMultiplier = 1.10},
      {stat = "maxHealth", baseMultiplier = 1.03},
      {stat = "maxEnergy", baseMultiplier = 0.9}
    })
  else
    status.clearPersistentEffects("starvationpower")
  end
  
end

function uninit()
  status.clearPersistentEffects("starvationpower")
  status.clearPersistentEffects("starvationpower2")
  status.clearPersistentEffects("jungleEpic")
end