didit = false

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return else didit = true end

    self.raceJson = root.assetJson("/scripts/raceEffects.config")
    self.specialConfig = self.raceJson[self.species].specialConfig

    if self.specialConfig then
        self.specialConfig = self.specialConfig.avianAerialBonus
    end

    self.flightPowerModifier = config.getParameter("flightPowerModifier")        -- Power bonus when in air
    self.windSpeedHigh = config.getParameter("windSpeedHigh")                    -- Wind bonus upper bound
    self.windSpeedLow = config.getParameter("windSpeedLow")                      -- Wind bonus lower bound
    self.windProtectionModifier = config.getParameter("windProtectionModifier")  -- Wind protection bonus
    self.windHealthModifier = config.getParameter("windHealthModifier")          -- Wind health bonus
    self.windSpeedModifier = config.getParameter("windSpeedModifier")            -- Wind speed bonus
    self.windJumpModifier = config.getParameter("windJumpModifier")              -- Wind jump bonus
    self.windForceModifier = config.getParameter("windForceModifier")            -- Wind jump force modifier?
    self.fallForce = config.getParameter("fallForce")                            -- ???
    self.fallRunSpeed = config.getParameter("fallRunSpeed")                      -- ???
    self.fallWalkSpeed = config.getParameter("fallWalkSpeed")                    -- ???
    self.maxFallSpeed = config.getParameter("maxFallSpeed")                      -- Terminal velocity?

    -- Species-specific configurations, if applicable
    if self.specialConfig then
        self.flightPowerModifier = self.specialConfig.flightPowerModifier or self.flightPowerModifier
        self.windSpeedHigh = self.specialConfig.windSpeedHigh or self.windSpeedHigh
        self.windSpeedLow = self.specialConfig.windSpeedLow or self.windSpeedLow
        self.windProtectionModifier = self.specialConfig.windProtectionModifier or self.windProtectionModifier
        self.windHealthModifier = self.specialConfig.windHealthModifier or self.windHealthModifier
        self.windSpeedModifier = self.specialConfig.windSpeedModifier or self.windSpeedModifier
        self.windJumpModifier = self.specialConfig.windJumpModifier or self.windJumpModifier
        self.windForceModifier = self.specialConfig.windForceModifier or self.windForceModifier
        self.fallForce = self.specialConfig.fallForce or self.fallForce
        self.fallRunSpeed = self.specialConfig.fallRunSpeed or self.fallRunSpeed
        self.fallWalkSpeed = self.specialConfig.fallWalkSpeed or self.fallWalkSpeed
        self.maxFallSpeed = self.specialConfig.maxFallSpeed or self.maxFallSpeed
    end

    script.setUpdateDelta(10)
end

function update(dt)
    if not didit then init() end

    if not mcontroller.onGround() then
        status.setPersistentEffects("avianflightpower", {
            {stat = "powerMultiplier", baseMultiplier = self.flightPowerModifier}
        })
    else
        status.clearPersistentEffects("avianflightpower")
    end

    if mcontroller.falling() then
        mcontroller.controlParameters({
            airForce = self.fallForce,
            runSpeed = self.fallRunSpeed,
            walkSpeed = self.fallWalkSpeed
        })
        mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), self.maxFallSpeed))
    end

    if (world.windLevel(mcontroller.position()) >= self.windSpeedHigh ) then
        --maxFallSpeed = -30
        status.clearPersistentEffects("avianwindbonus")
    elseif (world.windLevel(mcontroller.position()) >= self.windSpeedLow ) then
        --maxFallSpeed = -32
        status.setPersistentEffects("avianwindbonus", {
            {stat = "protection", baseMultiplier = self.windProtectionModifier},
            {stat = "maxHealth", baseMultiplier = self.windHealthModifier}
        })
        mcontroller.controlModifiers({
            speedModifier = self.windSpeedModifier,
            airJumpModifier = self.windJumpModifier,
            airForce = self.windForceModifier
        })
    end
end

function uninit()
    status.clearPersistentEffects("avianwindbonus")
    status.clearPersistentEffects("avianflightpower")
end
