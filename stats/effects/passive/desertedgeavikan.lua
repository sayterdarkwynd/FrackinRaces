function init()
  script.setUpdateDelta(25)
  self.healingRate = 1.0 / 200
end

function update(dt)
	if (world.type() == "desert") or (world.type() == "desertwastes") or (world.type() == "desertwastesdark") then
	status.modifyResourcePercentage("health", self.healingRate * dt)
	end 

end

function uninit()
  
end
