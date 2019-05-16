function init()
	self.foodTypes = config.getParameter("foodTypes")
	self.dietConfig = root.assetJson("/scripts/fr_diets.config")
	self.species = world.entitySpecies(entity.id())
	self.diet = root.assetJson("/species/"..self.species..".raceeffect").diet
	
	-- Grab premade diet
	if type(self.diet) == "string" then
		self.diet = self.dietConfig.diets[self.diet]
	end
	
	self.goodFood = config.getParameter("safeByDefault", true) -- If the race has no dietary data, follow the default
	if self.diet ~= nil then
		self.goodFood = false -- After assuming default for no data, always assume false if we do ;)
		self.applyBonus = true
		local whitelist = self.diet[1]
		local blacklist = self.diet[2]
		for _,foodType in pairs(self.foodTypes) do
			if not checkFood(whitelist, blacklist, foodType) then break end
		end
	end
	
	if not self.goodFood then
		for _,badStuff in pairs(config.getParameter("badStuff", {})) do
			status.addEphemeralEffect(badStuff)
		end
		if status.resourcePercentage("food") > 0.85 then status.setResourcePercentage("food", 0.85) end
		world.sendEntityMessage(entity.id(), "queueRadioMessage", "foodtype")
	elseif self.applyBonus then
		for _,bonusStuff in pairs(config.getParameter("bonusStuff", {})) do
			status.addEphemeralEffect(bonusStuff)
		end
	end
end

function update(dt)
	effect.expire()
end

function checkFood(whitelist, blacklist, foodType)
	local parent = self.dietConfig.groups[foodType]
	-- If the type is in the whitelist (can eat)
	if whitelist[foodType] ~= nil then
		self.goodFood = true
		-- Disable diet bonus if applicable
		if not whitelist[foodType] then
			self.applyBonus = false
		end
	-- If the type is in the blacklist (can't eat)
	elseif blacklist[foodType] then
		self.goodFood = false
		-- Return false to indicate we should stop; we can't eat this
		return false
	-- If the type wasn't found, but there is a parent, check the parent
	elseif self.dietConfig.groups[foodType] then
		-- Handling for multiple parenting (weird shit, but yeah)
		-- Checks ALL parents, but only needs ONE to succeed
		if type(parent) == "table" then
			local result = false
			for par in pairs(parent) do
				if checkFood(whitelist, blacklist, par) then
					result = true
				end
			end
			return result
		end
		return checkFood(whitelist, blacklist, parent)
	end
	-- Return true to indicate we should keep checking types
	return true
end