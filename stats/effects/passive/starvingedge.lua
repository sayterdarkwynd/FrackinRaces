function init()
	starvationpower=status.addStatModifierGroup({}) 
	script.setUpdateDelta(5)
end

function update(dt)
	self.foodvalue = status.isResource("food") and status.resource("food") or 100

	if self.foodvalue < 0.3 then
		status.setStatModifierGroup(starvationpower, {{stat = "powerMultiplier", baseMultiplier = 1.24}})
	elseif self.foodvalue < 10 then
		status.setStatModifierGroup(starvationpower, {{stat = "powerMultiplier", baseMultiplier = 1.20}})
	elseif self.foodvalue < 20 then
		status.setStatModifierGroup(starvationpower, {{stat = "powerMultiplier", baseMultiplier = 1.15}}) 
	elseif self.foodvalue < 30 then
		status.setStatModifierGroup(starvationpower, {{stat = "powerMultiplier", baseMultiplier = 1.09}})  
	elseif self.foodvalue < 40 then
		status.setStatModifierGroup(starvationpower, {{stat = "powerMultiplier", baseMultiplier = 1.07}})    
	elseif self.foodvalue < 50 then
		status.setStatModifierGroup(starvationpower, {{stat = "powerMultiplier", baseMultiplier = 1.05}}) 
	elseif self.foodvalue < 60 then
		status.setStatModifierGroup(starvationpower, {{stat = "powerMultiplier", baseMultiplier = 1.03}})  
	else
		status.setStatModifierGroup(starvationpower,{}) 
	end
end

function uninit()
	status.removeStatModifierGroup(starvationpower)
end












