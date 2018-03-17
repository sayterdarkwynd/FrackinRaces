require "/scripts/vec2.lua"
require "/scripts/util.lua"
require "/scripts/interp.lua"

function init()
  local bounds = mcontroller.boundBox()
  self.healingRate = 1.008 / config.getParameter("healTime", 220)
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


function nighttimeCheck()
	return world.timeOfDay() > 0.5 -- true if night
end

function undergroundCheck()
	return world.underground(mcontroller.position()) 
end

function update(dt)
  nighttime = nighttimeCheck()
  underground = undergroundCheck()
  valueVal = 5
  
  if status.isResource("food") then
    self.foodValue = status.resource("food")
  else
    self.foodValue = 70
  end
  
  local lightLevel = getLight()
  
    if nighttime or underground and (self.foodValue >= 45) then
	  self.healingRate = 1.007 / config.getParameter("healTime", 220)
	  status.modifyResourcePercentage("health", self.healingRate * dt)
	  
	  status.setPersistentEffects("feneroxEffects", {
	    {stat = "energyRegenPercentageRate", amount = config.getParameter("powerBonus",0)},
	    {stat = "maxHealth", baseMultiplier = config.getParameter("powerBonus",0) + 1.08},
	    {stat = "powerMultiplier", baseMultiplier = config.getParameter("powerBonus",0) + 1.08}
	  })
    else
          status.clearPersistentEffects("feneroxEffects")
    end
end

function uninit()
  status.clearPersistentEffects("feneroxEffects")
end