require("/scripts/util.lua")
require("/scripts/FRHelper.lua")

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return end

    self.helper = FRHelper:new(self.species,world.entityGender(entity.id()))

    -- Load extra scripts (environmental effects, aerial bonuses, etc.)
    for map,path in pairs(self.helper.frconfig.scriptMaps) do
        if self.helper.speciesConfig[map] then
            self.helper:loadScript({script=path, args=self.helper.speciesConfig[map]})
        end
    end

    -- Add the stats
    self.statID = effect.addStatModifierGroup(self.helper.stats or {})

    script.setUpdateDelta(10)
end

function update(dt)
    if not self.species then init() end

	self.helper:applyControlModifiers()
    self.helper:clearPersistent()
    self.helper:runScripts("racialscript", self, dt)
end

function uninit()
    if self.statID then
        effect.removeStatModifierGroup(self.statID)
    end
    if self.helper then
        self.helper:clearPersistent()
    end
end
