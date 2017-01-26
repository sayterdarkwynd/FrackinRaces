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
  getLight()
  daytimeCheck()
  
  --food defaults
  if status.resource("food") then hungerLevel = status.resource("food") else hungerLevel = 60 end
  hungerMax = { pcall(status.resourceMax, "food") }
  hungerMax = hungerMax[1] and hungerMax[2]
  
  self.tickTimer = self.tickTimer - dt
  self.tickTimerPenalty = self.tickTimerPenalty - dt
  
  -- first, make sure they are actually wounded so nothing is wasted pointlessly, 
  -- and then start regen when adequately wounded
  if (status.resource("health") <= status.stat("maxHealth")/2) then
    -- while they still regen at night, it consumes a lot more food from the Novakid
    if not daytime then  
      if ( self.tickTimer <= 0 ) then
        self.tickTimer = self.tickTime
        adjustedHunger = hungerLevel + ( hungerLevel * -0.007 )
        status.setResource( "food", adjustedHunger )
      end
    end
	if daytime then
	  sb.logInfo(self.foodvalue)
	  if hungerLevel > 20 then
	   self.healingRate = 1.0005 / 220
	   status.modifyResourcePercentage("health", self.healingRate * dt)
	  elseif hungerLevel > 40 then
	   self.healingRate = 1.0009 / 220
	   status.modifyResourcePercentage("health", self.healingRate * dt)
	  elseif hungerLevel > 60 then
	   self.healingRate = 1.001 / 220
	   status.modifyResourcePercentage("health", self.healingRate * dt)    
	  end
	else
	  if hungerLevel > 20 then
	   self.healingRate = 1.0005 / 420
	   status.modifyResourcePercentage("health", self.healingRate * dt)
	  elseif hungerLevel > 40 then
	   self.healingRate = 1.0009 / 420
	   status.modifyResourcePercentage("health", self.healingRate * dt)		   
	  elseif hungerLevel > 60 then
	   self.healingRate = 1.001 / 420
	   status.modifyResourcePercentage("health", self.healingRate * dt) 
	  end	
	end  
   end
end

function uninit()

end







