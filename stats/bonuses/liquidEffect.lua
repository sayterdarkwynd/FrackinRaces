require("/scripts/vec2.lua")

--[[
    This script is for applying effects while the race is in liquids.
    Structure:

    "liquidEffects" : [
        -- effect 1
        {
            "name" : "thingy"            -- name of the effect, useful for detection in other scripts; optional
            "liquids" : [ 1, 2, 3, 4 ]   -- liquids that trigger the effect; optional (no liquids means any liquid will work)
            "stats" : []                 -- put stat changes in here, just like normal
            "controlModifiers" : {}      -- just like normal
            "controlParameters" : {}     -- you should get the picture by now
            "status" : [ "glow" ]        -- put any status effects to be applied in here
        },
        -- effect 2
        {
            -- you can have as many effects as you want
        }
    ]

]]

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return end

    self.raceConfig = root.assetJson("/scripts/raceEffects.config")[self.species]

    script.setUpdateDelta(10)
end

function update(dt)
    if not self.raceConfig then init() end

    local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))

    for i,thing in ipairs(self.raceConfig.liquidEffects or {}) do
        if world.liquidAt(mouthPosition) and (not thing.liquids or contains(thing.liquids, mcontroller.liquidId())) then
            status.setPersistentEffects(thing.name or "liquidEffect"..i, thing.stats)
            mcontroller.controlModifiers(thing.controlModifiers)
            mcontroller.controlParameters(thing.controlParameters)
            for x,thing2 in ipairs(thing.status or {}) do
                status.addEphemeralEffect(thing2, math.huge)
            end
        else
            status.clearPersistentEffects(thing.name or "liquidEffect"..i)
            for x,thing2 in ipairs(thing.status or {}) do
                status.removeEphemeralEffect(thing2)
            end
        end
    end
end

function uninit()
    for i,thing in ipairs(self.raceConfig.liquidEffects or {}) do
        status.clearPersistentEffects(thing.name or "liquidEffect"..i)
        for x,thing2 in ipairs(thing.status or {}) do
            status.removeEphemeralEffect(thing2)
        end
    end
end
