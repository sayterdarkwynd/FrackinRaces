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

  if self.foodvalue < 0.3 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.30}})
  elseif self.foodvalue < 10 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.25}})
  elseif self.foodvalue < 20 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.20}}) 
  elseif self.foodvalue < 30 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.16}})  
  elseif self.foodvalue < 40 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.12}})    
  elseif self.foodvalue < 50 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.07}}) 
  elseif self.foodvalue < 60 then
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.03}})        
  else
    status.setPersistentEffects("starvationpower", {{stat = "powerMultiplier", baseMultiplier = 1.00}}) 
    status.clearPersistentEffects("starvationpower")
  end

end

function uninit()

end












