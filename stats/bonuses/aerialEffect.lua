require("/scripts/util.lua")

--[[
    This script is for providing bonuses based on the aerial status of the player.
    It has support for effects when in the air, on the ground, falling, and based on wind speed.

    Structure:

    "aerialEffect" : {
        "airStats" : {
            -- Stuff for what happens when in the air
        },
        "groundStats" : {
            -- Stuff for what happens when on the ground
        },
        "fallStats" : {
            -- Stuff for what happens when falling
            "maxFallSpeed" : -30    -- Allows setting the max fall speed
        },
        "windEffects" : {
            "windHigh" : {
                -- Settings for when the wind is at a "high" level (overrides the "low" level)
                "speed" : 60   -- Which wind speed this triggers at
            },
            "windLow" : {
                -- Settings for when the wind is at a "low" level
                "speed" : 7    -- Which wind speed this triggers at
            }
        }
    }
]]

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return end

    self.raceJson = root.assetJson("/scripts/raceEffects.config")
    self.effectConfig = (self.raceJson[self.species] or {}).aerialEffect

    if self.effectConfig then
        self.aerialEffect = self.effectConfig.airStats
        self.fallEffect = self.effectConfig.fallStats
        self.groundEffect = self.effectConfig.groundStats -- Support for ground-only effects too!
        self.windEffects = self.effectConfig.windEffects
    end

    script.setUpdateDelta(10)
end

function update(dt)
    if not self.species then init() end

    status.clearPersistentEffects("aerialStats")
    status.clearPersistentEffects("groundStats")
    -- Effects while in the air
    if self.aerialEffect and not mcontroller.onGround() then
        applyStatus("aerialStats", self.aerialEffect)
	elseif self.groundEffect then
        applyStatus("groundStats", self.groundEffect)
    end

    -- Effects while falling
	if self.fallEffect and mcontroller.falling() then
        applyStatus("fallStats", self.fallEffect)
        if self.fallEffect.maxFallSpeed then
            mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), self.fallEffect.maxFallSpeed))
        end
	else
        status.clearPersistentEffects("fallStats")
    end

    -- Wind effects
    if self.windEffects and self.windEffects.windHigh and (world.windLevel(mcontroller.position()) >= self.windEffects.windHigh.speed) then
        applyStatus("windStats", self.windEffects.windHigh)
	elseif self.windEffects and self.windEffects.windLow and (world.windLevel(mcontroller.position()) >= self.windEffects.windLow.speed ) then
        applyStatus("windStats", self.windEffects.windHigh)
	else
        status.clearPersistentEffects("windStats")
    end
end

function applyStatus(name, table)
    status.setPersistentEffects(name, table.stats or {})
    mcontroller.controlModifiers(table.controlModifiers or {})
    mcontroller.controlParameters(table.controlParameters or {})
end

function uninit()
    status.clearPersistentEffects("aerialStats")
    status.clearPersistentEffects("fallStats")
    status.clearPersistentEffects("groundStats")
    status.clearPersistentEffects("windStats")
end
