require("/scripts/util.lua")
didit = false

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return else didit = true end

    self.raceJson = root.assetJson("/scripts/raceEffects.config")
    self.speciesConfig = self.raceJson[self.species]
    --self.specialConfig = self.raceJson[self.species].specialConfig

    --if self.specialConfig then
    --    self.specialConfig = self.specialConfig.avianAerialBonus
    --end

    script.setUpdateDelta(10)
end

function update(dt)
    if not didit then init() end

    if not mcontroller.onGround() then
        --if self.speciesConfig.envEffects and contains(self.speciesConfig.environmentalWeakness.biomes, world.type()) then
            --status.clearPersistentEffects("flightPower")
        --else
            status.setPersistentEffects("flightPower", {
                {stat = "powerMultiplier", baseMultiplier = 1.1}
            })
        --end
	else
        status.clearPersistentEffects("flightPower")
    end

	if mcontroller.falling() then
        mcontroller.controlParameters(config.getParameter("fallingParameters"))
        mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed")))
	end

    if (world.windLevel(mcontroller.position()) >= 70 ) then
		mcontroller.controlModifiers({
            speedModifier = 1.12,
            airJumpModifier = 1.12
		})
	elseif (world.windLevel(mcontroller.position()) >= 7 ) then
		mcontroller.controlModifiers({
            speedModifier = 1.20,
            airJumpModifier = 1.20
		})
	end
end

function uninit()
    status.clearPersistentEffects("flightPower")
end
