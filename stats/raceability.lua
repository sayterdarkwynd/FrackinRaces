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
	for _,script in pairs(self.helper.speciesConfig.scripts or {}) do
		self.helper:loadScript(script)
	end

    script.setUpdateDelta(10)
end

function update(dt)
    if not self.species then init() end

    self.helper:clearPersistent()
	self.helper:applyControlModifiers()
	self.helper:applyPersistent(self.helper.speciesConfig.stats, "FR_racialStats")
    self.helper:runScripts("racialscript", self, dt)
end

function uninit()
    if self.helper then
        self.helper:clearPersistent()
    end
end
