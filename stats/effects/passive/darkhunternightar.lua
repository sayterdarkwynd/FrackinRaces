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
function daytimeCheck()
	return world.timeOfDay() < 0.5 -- true if daytime
end

function undergroundCheck()
	return world.underground(mcontroller.position()) 
end


function update(dt)
  daytime = daytimeCheck()
  underground = undergroundCheck()
  local lightLevel = getLight()
      -- day penalty
	if daytime and lightLevel > 85 and not underground then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 0.75},
	  {stat = "physicalResistance", amount = -0.20},
	  {stat = "powerMultiplier", baseMultiplier = 0.75}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 0.90 })  
	elseif daytime and lightLevel > 70 and not underground then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 0.80},
	  {stat = "physicalResistance", amount = -0.15},
	  {stat = "powerMultiplier", baseMultiplier = 0.85}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 0.95 }) 
	elseif daytime and lightLevel > 50 and not underground then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 0.85},
	  {stat = "physicalResistance", amount = -0.1},
	  {stat = "powerMultiplier", baseMultiplier = 0.90}
	  })		
	  mcontroller.controlModifiers({ speedModifier = 0.97 }) 
	elseif daytime and lightLevel > 35 and not underground then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 0.90},
	  {stat = "physicalResistance", amount = -0.05},
	  {stat = "powerMultiplier", baseMultiplier = 0.95}
	  })	
	-- end day penalty  
        elseif lightLevel <= 1 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.20,
	  {stat = "maxEnergy", baseMultiplier = 1.25},
	  {stat = "physicalResistance", amount = 0.25}
	  })		
	elseif lightLevel <= 3 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.15,
	  {stat = "maxEnergy", baseMultiplier = 1.20,
	  {stat = "physicalResistance", amount = 0.225}
	  })			
	elseif lightLevel <= 5 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.1,
	  {stat = "maxEnergy", baseMultiplier = 1.18,
	  {stat = "physicalResistance", amount = 0.20}
	  })		
	elseif lightLevel <= 8 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.12,
	  {stat = "maxEnergy", baseMultiplier = 1.16,
	  {stat = "physicalResistance", amount = 0.15}
	  })			  
	elseif lightLevel <= 10 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.10,
	  {stat = "maxEnergy", baseMultiplier = 1.14,
	  {stat = "physicalResistance", amount = 0.12}
	  })			
	elseif lightLevel <= 15 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.07,
	  {stat = "maxEnergy", baseMultiplier = 1.12,
	  {stat = "physicalResistance", amount = 0.10}
	  })			  
	elseif lightLevel <= 25 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.05,
	  {stat = "maxEnergy", baseMultiplier = 1.10,
	  {stat = "physicalResistance", amount = 0.05}
	  })		
	else
	  status.clearPersistentEffects("feneroxEffects")
	end  
end

function uninit()
  status.clearPersistentEffects("feneroxEffects")
end