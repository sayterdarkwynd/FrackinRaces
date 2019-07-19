--require("/scripts/vec2.lua")
--require("/scripts/FRHelper.lua")

local FR_old_init = init
--local FR_old_update = update

function init()
	FR_old_init()
	local species = player.species()
	local _,speciesConfig = pcall( function () return root.assetJson(string.format("/species/%s.raceeffect", species)) end )
	if speciesConfig and speciesConfig.tech then
		for _,tech in pairs(speciesConfig.tech) do
			local playerTechs = player.availableTechs()
			player.makeTechAvailable(tech)
			if #(player.availableTechs()) > #playerTechs then -- check to see if this added a tech (if not, we have it already)
				player.enableTech(tech)
				player.equipTech(tech)
			end
		end
	end
end

--[[function update(dt)
	FR_old_update(dt)
	
	if not self.species then
		self.species = world.entitySpecies(entity.id())
		self.helper = FRHelper:new(self.species, world.entityGender(entity.id()))
		
		-- Script setup
		for map,path in pairs(self.helper.frconfig.scriptMaps) do
			if self.helper.speciesConfig[map] then
				self.helper:loadScript({script=path, args=self.helper.speciesConfig[map]})
			end
		end
		for _,script in pairs(self.helper.speciesConfig.scripts or {}) do
			self.helper:loadScript(script)
		end
		
		-- Apply the persistent effect
		status.setPersistentEffects("FR_racialStats", self.helper.speciesConfig.stats or {})
		
		-- Add any other special effects
		if self.helper.speciesConfig.special then
			for _,thing in pairs(self.helper.speciesConfig.special) do
				status.addEphemeralEffect(thing,math.huge)
			end
		end
	end
	
	-- Update stuff
	--self.helper:clearPersistent()
	self.helper:applyControlModifiers()
	self.helper:runScripts("racialscript", self, dt)
	
	-- Breath handling
	if entity.entityType() ~= "npc" then
		local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
		if status.statPositive("breathProtection") or world.breathable(mouthPosition)
			or status.statPositive("waterbreathProtection") and world.liquidAt(mouthPosition)
			then
			status.modifyResource("breath", status.stat("breathRegenerationRate") * dt)
		else
			status.modifyResource("breath", -status.stat("breathDepletionRate") * dt)
		end
	end
end]]
