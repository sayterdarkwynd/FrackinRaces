function init()
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
 
    --food defaults
    if status.resource("food") then
      local foodvalue = status.resource("food")
      hungerLevel = status.resource("food")
    else
      local foodvalue = 60
      hungerLevel = 60
    end

    hungerMax = { pcall(status.resourceMax, "food") }
    hungerMax = hungerMax[1] and hungerMax[2]

    self.tickTime = 1.0
    self.tickTimePenalty = 5.0
    self.tickTimer = self.tickTime 
    self.tickTimerPenalty = self.tickTimePenalty
    self.healingRate = 1.001 / 60
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

  -- time checks
  daytime = daytimeCheck()
  underground = undergroundCheck()
  local lightLevel = getLight()
  
  --food defaults
  if status.resource("food") then hungerLevel = status.resource("food") else hungerLevel = 60 end
  hungerMax = { pcall(status.resourceMax, "food") }
  hungerMax = hungerMax[1] and hungerMax[2]
  if not hungerMax then hungerMax = 70 end

  -- health defaults
  if status.resource("health") then healthLevel = status.resource("health") else healthLevel = 100 end
  
  -- timer
  self.tickTimer = self.tickTimer - dt
  self.tickTimerPenalty = self.tickTimerPenalty - dt


  if not daytime then -- at night, lose 25% energy. Actual light is not important...only the solar cycle is
    status.setPersistentEffects("nightpenalty", { 
      {stat = "maxEnergy", baseMultiplier = 0.75 } 
    })
  else 
    status.clearPersistentEffects("nightpenalty") 
  end 
    
  -- begin regen effect  
  if (status.resource("health") <= status.stat("maxHealth")) then -- make sure they are actually wounded so nothing is wasted pointlessly, and then start regen when adequately wounded
    if (self.tickTimer <= 0 ) and hungerLevel >=28 then  -- has timer reached 0? is there enough Food?
      self.tickTimer = self.tickTime
      if daytime then -- during the day when 50% fed or more we get regen with no need to consume food
	  if hungerLevel > 45 then
	   self.healingRate = 1.009 / 60
	   status.modifyResourcePercentage("health", self.healingRate * dt)
	  elseif hungerLevel > 60 then
	   self.healingRate = 1.03 / 60
	   status.modifyResourcePercentage("health", self.healingRate * dt)    
	  end 
	    status.setPersistentEffects("daybonus", { 
	      {stat = "energyRegenPercentageRate", baseMultiplier = 1.20 } 
	    })	  
      end
      if not daytime then -- while they still regen at night, it consumes a lot more food from the Novakid
         if hungerLevel > 45 then -- do we have enough foor to regen?
           adjustedHunger = hungerLevel + ( hungerLevel * -0.0005 )
           status.setResource( "food", adjustedHunger )            
           self.healingRate = 1.001 / 60
	   status.modifyResourcePercentage("health", self.healingRate * dt)
	 end 
	 status.clearPersistentEffects("daybonus")  
      end
    end
  end
  
  
end








