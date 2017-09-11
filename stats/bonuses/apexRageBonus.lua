didit = false

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return else didit = true end

    self.raceJson = root.assetJson("/scripts/raceEffects.config")
    self.specialConfig = self.raceJson[self.species].specialConfig or nil

    if self.specialConfig then
        self.specialConfig = self.specialConfig.apexRageBonus or nil
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

	-- range at which the effects start kicking in. 80% health?
    local healthRange = self.healthRangeConfig or config.getParameter("healthRange")
	self.healthRange = (status.stat("maxHealth") * healthRange)

	-- what percent of health remains?
	self.percentRate = self.healthMin / self.healthMax

	--calculate core bonus
    self.powerMod = 2-self.percentRate / (self.healthRange / self.healthMax)

	-- other modifiers
    self.protectionMod = self.powerMod * 2
    self.critMod = self.powerMod * 5

    -- make sure it doesn't get wonky by setting limits
    if (self.powerMod) < 1 then
        self.powerMod = 1
	elseif (self.powerMod) >= 1.3 then  -- max 30%
        self.powerMod = 1.3
	elseif (self.protectionMod) >= 1.20 then  -- max 20%
        self.protectionMod = 1.2
	elseif (self.critMod) >= 5 then  -- max 5
        self.critMod = 5
	end


    -- apex lose energy but gain power as they take damage (and vice versa)
	if (self.healthMin >= self.healthMax) then
        status.clearPersistentEffects("apexPower")
	elseif (self.percentRate) <= (self.healthRange) then
        status.setPersistentEffects("apexPower", {
            {stat = "maxEnergy", baseMultiplier = self.percentRate },
            {stat = "powerMultiplier", baseMultiplier = self.powerMod },
            {stat = "protection", baseMultiplier = self.protectionMod },
            {stat = "critChance", amount = self.critMod }
        })
    end
end

function uninit()
    status.clearPersistentEffects("apexPower")
end
