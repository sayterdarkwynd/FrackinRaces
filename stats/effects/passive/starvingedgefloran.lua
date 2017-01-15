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

  if self.foodvalue > 95 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.30}})  
  elseif self.foodvalue > 90 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.27}})  
  elseif self.foodvalue > 85 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.25}})
  elseif self.foodvalue > 80 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.22}})   
  elseif self.foodvalue > 75 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.20}})  
  elseif self.foodvalue > 70 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.17}})
  elseif self.foodvalue > 65 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.15}})  
  elseif self.foodvalue > 60 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.12}})  
  elseif self.foodvalue > 55 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.09}})
  elseif self.foodvalue > 50 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.07}})   
  elseif self.foodvalue > 45 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.05}})  
  elseif self.foodvalue > 40 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.03}})
  elseif self.foodvalue > 35 then
    status.setPersistentEffects("starvationpower2", {{stat = "maxEnergy", baseMultiplier = 1.01}})      
  else
    status.clearPersistentEffects("starvationpower2")
  end    
  
  if self.foodvalue < 5 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.24}})
  elseif self.foodvalue < 10 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.20}})
  elseif self.foodvalue < 20 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.15}}) 
  elseif self.foodvalue < 30 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.09}})  
  elseif self.foodvalue < 40 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.07}})    
  elseif self.foodvalue < 50 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.05}}) 
  elseif self.foodvalue < 60 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.03}}) 
  else
    status.clearPersistentEffects("starvationpower")
  end

	  
end

function uninit()
  status.clearPersistentEffects("starvationpower")
  status.clearPersistentEffects("starvationpower2")
end









