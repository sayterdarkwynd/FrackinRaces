require("/scripts/vec2.lua")

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return end

    self.raceJson = root.assetJson("/species/skelekin.raceeffect")

    self.healingRateGood = 0.015
    self.healingRateBad = 0.045

    if self.raceJson.skelekinRegen then
        self.healingRateGood = self.raceJson.skelekinRegen.goodRegen or self.healingRateGood
        self.healingRateBad = self.raceJson.skelekinRegen.badRegen or self.healingRateBad
    end
end

function update(dt)
    if not self.species then init() end

    if #status.getPersistentEffects("skelekinGoodLiquid") ~= 0 then
        status.modifyResourcePercentage("health", self.healingRateGood * dt)
	elseif #status.getPersistentEffects("skelekinBadLiquid") ~= 0 then
        status.modifyResourcePercentage("health", -self.healingRateBad * dt)
    end
end

function uninit()
end
