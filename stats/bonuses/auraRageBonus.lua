didit = false

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return else didit = true end

    self.raceJson = root.assetJson("/scripts/raceEffects.config")
    self.specialConfig = self.raceJson[self.species].specialConfig or nil

    if self.specialConfig then
        self.specialConfig = self.specialConfig.auraRageBonus or nil
    end

    self.healthRange = nil
    if self.specialConfig then
        self.healthRangeConfig = self.specialConfig.healthRange or nil
    end

    script.setUpdateDelta(10)
end

function update(dt)
    if not didit then init() end

    -- check their existing health levels
	self.healthMin = status.resource("health")
	self.healthMax = status.stat("maxHealth")

	-- range at which the effects start kicking in. all the time
    local healthRange = self.healthRangeConfig or config.getParameter("healthRange")
	self.healthRange = (status.stat("maxHealth") * healthRange)

	-- what percent of health remains?
	self.percentRate = self.healthMin / self.healthMax
	-- modyfiers
    self.powerMod = 1
    self.protectionMod = 1

    -- make the core bonus
	if (self.pecentRate) <= 0.75 and > 0.5 then
		self.powermod = 1.05
		elseif (self.pecentRate) <= 0.5 and > 0.25 then
		self.powermod = 1.1
		self.protectionMod = 0.95
		elseif (self.pecentRate) <= 0.25 then
		self.powermod = 1.15
		self.protectionMod = 0.9
	end	
	
    -- lucario lose protection but gain power as they take damage (and vice versa)
	if (self.healthMin >= self.healthMax) then
        status.clearPersistentEffects("auraPower")
	elseif (self.percentRate) <= (self.healthRange) then
        status.setPersistentEffects("auraPower", {
            {stat = "powerMultiplier", baseMultiplier = self.powerMod },
            {stat = "protection", baseMultiplier = self.protectionMod },
        })
    end
end

function uninit()
    status.clearPersistentEffects("auraPower")
end