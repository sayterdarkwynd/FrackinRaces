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
      
      if daytime then
      sb.logInfo(daytime)
      sb.logInfo(underground)
        if not underground then
		if lightLevel > 85 then
		  status.setPersistentEffects("feneroxEffects", {
		  {stat = "maxHealth", baseMultiplier = 0.75},
		  {stat = "physicalResistance", amount = -0.20},
		  {stat = "powerMultiplier", baseMultiplier = 0.75}
		  })		
		  mcontroller.controlModifiers({ speedModifier = 0.90 })  
		elseif lightLevel > 75 then
		  status.setPersistentEffects("feneroxEffects", {
		  {stat = "maxHealth", baseMultiplier = 0.80},
		  {stat = "physicalResistance", amount = -0.15},
		  {stat = "powerMultiplier", baseMultiplier = 0.85}
		  })		
		  mcontroller.controlModifiers({ speedModifier = 0.95 }) 
		elseif lightLevel > 65 then
		  status.setPersistentEffects("feneroxEffects", {
		  {stat = "maxHealth", baseMultiplier = 0.85},
		  {stat = "physicalResistance", amount = -0.1},
		  {stat = "powerMultiplier", baseMultiplier = 0.90}
		  })		
		  mcontroller.controlModifiers({ speedModifier = 0.97 }) 
		elseif lightLevel > 55 then
		  status.setPersistentEffects("feneroxEffects", {
		  {stat = "maxHealth", baseMultiplier = 0.90},
		  {stat = "physicalResistance", amount = -0.05},
		  {stat = "powerMultiplier", baseMultiplier = 0.95}
		  })
		else
		  status.clearPersistentEffects("feneroxEffects")
		end    
		
        end
      end

      if not daytime or daytime and underground then
        if lightLevel <= 19 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.20},
	  {stat = "maxEnergy", baseMultiplier = 1.25},
	  {stat = "physicalResistance", amount = 0.25}
	  })		
	elseif lightLevel <= 21 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.15},
	  {stat = "maxEnergy", baseMultiplier = 1.20},
	  {stat = "physicalResistance", amount = 0.225}
	  })			
	elseif lightLevel <= 23 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.1},
	  {stat = "maxEnergy", baseMultiplier = 1.18},
	  {stat = "physicalResistance", amount = 0.20}
	  })		
	elseif lightLevel <= 25 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.12},
	  {stat = "maxEnergy", baseMultiplier = 1.16},
	  {stat = "physicalResistance", amount = 0.15}
	  })			  
	elseif lightLevel <= 32 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.10},
	  {stat = "maxEnergy", baseMultiplier = 1.14},
	  {stat = "physicalResistance", amount = 0.12}
	  })			
	elseif lightLevel <= 40 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.07},
	  {stat = "maxEnergy", baseMultiplier = 1.12},
	  {stat = "physicalResistance", amount = 0.10}
	  })			  
	elseif lightLevel <= 45 then
	  status.setPersistentEffects("feneroxEffects", {
	  {stat = "maxHealth", baseMultiplier = 1.05},
	  {stat = "maxEnergy", baseMultiplier = 1.10},
	  {stat = "physicalResistance", amount = 0.05}
	  })		
	else
	  status.clearPersistentEffects("feneroxEffects")
	end    
	sb.logInfo(lightLevel)
      end




end

function uninit()
  status.clearPersistentEffects("feneroxEffects")
end