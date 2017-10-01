require("/scripts/util.lua")
require("/scripts/FRHelper.lua")

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

    self.helper = FRHelper:new(self.species)

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

    self.helper:clearPersistent()

    -- Effects while in the air
    if self.aerialEffect and not mcontroller.onGround() then
        self.helper:applyStats(self.aerialEffect, "aerialStats")
	elseif self.groundEffect then
        self.helper:applyStats(self.groundEffect, "groundStats")
    end

    -- Effects while falling
	if self.fallEffect and mcontroller.falling() then
        self.helper:applyStats(self.fallEffect, "fallStats")
        if self.fallEffect.maxFallSpeed then
            mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), self.fallEffect.maxFallSpeed))
        end
    end

    -- Wind effects
    local windLevel = world.windLevel(mcontroller.position())
    if self.windEffects and self.windEffects.windHigh and windLevel >= self.windEffects.windHigh.speed then
        self.helper:applyStats(self.windEffects.windHigh, "windStats")
	elseif self.windEffects and self.windEffects.windLow and windLevel >= self.windEffects.windLow.speed then
        self.helper:applyStats(self.windEffects.windHigh, "windStats")
    end
end

function uninit()
    self.helper:clearPersistent()
end
