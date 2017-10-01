require("/scripts/util.lua")
require("/scripts/FRHelper.lua")

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return end

    self.helper = FRHelper:new(self.species)

    -- Add the stats
    self.statID = effect.addStatModifierGroup(self.helper.stats or {})

    script.setUpdateDelta(10)
end

function update(dt)
    if not self.species then init() end

	self.helper:applyControlModifiers()

    -- Environmental Effects
    for i,thing in ipairs(self.helper.envEffects or {}) do
        if thing.biomes and contains(thing.biomes, world.type()) then
            self.helper:applyStats(thing, "envEffect"..i)
        end
    end
end

function uninit()
    if self.statID then
        effect.removeStatModifierGroup(self.statID)
    end
    if self.helper then
        self.helper:clearPersistent()
    end
end
