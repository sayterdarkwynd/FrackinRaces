require("/scripts/util.lua")

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return end

    self.raceJson = root.assetJson("/scripts/raceEffects.config")
    self.raceConfig = self.raceJson[self.species]

    -- Add the stats
    self.statID = effect.addStatModifierGroup(self.raceConfig.stats or {})

    -- Environmental Effects (stats)
    for i,thing in ipairs(self.raceConfig.envEffects or {}) do
        if thing.stats and thing.biomes and contains(thing.biomes, world.type()) then
            status.setPersistentEffects("envEffect"..i, thing.stats)
        end
    end

    script.setUpdateDelta(10)
end

function update(dt)
    if not self.raceJson then init() end

    -- Control Modifiers
    local mods = self.raceConfig.controlModifiers or {}
    for i,thing in ipairs(self.raceConfig.envEffects or {}) do
        if thing.controlModifiers and contains(thing.biomes, world.type()) then
            util.mergeTable(mods, thing.controlModifiers)
        end
    end
	mcontroller.controlModifiers(mods)

    -- Control Parameters
    local params = self.raceConfig.controlParameters or {}
    for i,thing in ipairs(self.raceConfig.envEffects or {}) do
        if thing.controlParameters and contains(thing.biomes, world.type()) then
            util.mergeTable(mods, thing.controlParameters)
        end
    end
    mcontroller.controlParameters(params)
end

function uninit()
    effect.removeStatModifierGroup(self.statID)
    for i,thing in ipairs(self.raceConfig.envEffects or {}) do
        status.clearPersistentEffects("envEffect"..i)
    end
end
