--didit = false

function init()
    --[[self.species = world.entitySpecies(entity.id())
    if not self.species then return else didit = true end

    self.raceJson = root.assetJson("/scripts/raceEffects.config")
    self.specialConfig = self.raceJson[self.species].specialConfig
]]
    script.setUpdateDelta(10)
end

function update(dt)
    --if not didit then init() end

    self.healingRate = 1.00005 / 420 -- health per time - 0.005% health per 420ms, I think
    status.modifyResourcePercentage("health", self.healingRate * dt)
end
