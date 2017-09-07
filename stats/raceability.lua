require("/scripts/util.lua")

didit = false

function init()
    self.species = world.entitySpecies(entity.id())
    if not self.species then return else didit = true end

    self.raceJson = root.assetJson("/scripts/raceEffects.config")
    self.raceConfig = self.raceJson[self.species]

    self.foodType = {
        omnivore=0,
        carnivore=0,
        herbivore=0,
        robot=0
    }

    if self.raceConfig.food == "omnivore" then
        self.foodType.omnivore = 1
    elseif self.raceConfig.food == "carnivore" then
        self.foodType.carnivore = 1
    elseif self.raceConfig.food == "herbivore" then
        self.foodType.herbivore = 1
    elseif self.raceConfig.food == "robot" then
        self.foodType.robot = 1
    end


    local effects = {
        -- base Attributes
        {stat = "isOmnivore", amount = self.foodType.omnivore},
        {stat = "isCarnivore", amount = self.foodType.carnivore},
        {stat = "isHerbivore", amount = self.foodType.herbivore},
        {stat = "isRobot", amount = self.foodType.robot},
        {stat = "maxHealth", baseMultiplier = self.raceConfig.healthBonus or 1},
        {stat = "maxEnergy", baseMultiplier = self.raceConfig.energyBonus or 1},
        {stat = "powerMultiplier", baseMultiplier = self.raceConfig.attackBonus or 1},
        {stat = "protection", baseMultiplier = self.raceConfig.defenseBonus or 1},
        {stat = "fallDamageMultiplier", baseMultiplier = self.raceConfig.fallDamageMultiplier or 1},
        {stat = "maxBreath", amount = self.raceConfig.maxBreath or 0},

        -- resistances
        {stat = "physicalResistance", amount = self.raceConfig.physicalResistance or 0},
        {stat = "electricResistance", amount = self.raceConfig.electricResistance or 0},
        {stat = "fireResistance", amount = self.raceConfig.fireResistance or 0},
        {stat = "iceResistance", amount = self.raceConfig.iceResistance or 0},
        {stat = "poisonResistance", amount = self.raceConfig.poisonResistance or 0},
        {stat = "shadowResistance", amount = self.raceConfig.shadowResistance or 0},
        {stat = "cosmicResistance", amount = self.raceConfig.cosmicResistance or 0},
        {stat = "radioactiveResistance", amount = self.raceConfig.radioactiveResistance or 0},

        -- other
        {stat = "foodDelta", baseMultiplier = self.raceConfig.foodDelta or 1},
        {stat = "grit", amount = self.raceConfig.grit or 0}
    }

    for _,imm in pairs(self.raceConfig.immunities or {}) do
        table.insert(effects, {stat=imm, amount=1})
    end

    effect.addStatModifierGroup(effects)

    --Environment Bonus
    local envBonus = self.raceConfig.environmentalBonus
    if envBonus and contains(envBonus.biomes, world.type()) then
        status.setPersistentEffects("envBonus", {
            {stat = "maxHealth", baseMultiplier = envBonus.bonus.healthBonus or 1},
            {stat = "maxEnergy", baseMultiplier = envBonus.bonus.energyBonus or 1},
            {stat = "protection", baseMultiplier = envBonus.bonus.defenseBonus or 1}
        })
    end

    script.setUpdateDelta(10)
end

function update(dt)
    if not didit then init() end

	mcontroller.controlModifiers({
		speedModifier = self.raceConfig.speedModifier or 1,
		airJumpModifier = self.raceConfig.jumpModifier or 1
	})

    local params = {}
    if self.raceConfig.jumpSpeed then
        params["airJumpProfile"] = { jumpSpeed = self.raceConfig.jumpSpeed }
    end
    if self.raceConfig.jumpHoldTime then
        params["liquidJumpProfile"] = { jumpHoldTime = self.raceConfig.jumpHoldTime }
    end
    mcontroller.controlParameters(params)
end

function uninit()
    status.clearPersistentEffects("envBonus")
end
