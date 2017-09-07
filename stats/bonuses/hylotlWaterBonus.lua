require("/scripts/vec2.lua")
--didit = false

function init()
    inWater = 0
    --[[self.species = world.entitySpecies(entity.id())
    if not self.species then return else didit = true end

    self.raceJson = root.assetJson("/scripts/raceEffects.config")
    self.specialConfig = self.raceJson[self.species].specialConfig
]]

    if not status.stat("maxBreath") then
        self.baseBreath = 1
    else
        self.baseBreath = status.stat("maxBreath")
    end

    script.setUpdateDelta(10)
end

function update(dt)
    --if not didit then init() end

    if mcontroller.zeroG() and self.baseBreath > 1 then  -- disable extra breath in space
        status.setPersistentEffects("hylotlprotection", {
            {stat = "maxBreath", baseMultiplier = 1}
        })
	end

    local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
    local mouthful = world.liquidAt(mouthposition)
	if (world.liquidAt(mouthPosition)) and (inWater == 0) and (mcontroller.liquidId()== 1) or (mcontroller.liquidId()== 6) or (mcontroller.liquidId()== 58) or (mcontroller.liquidId()== 12) then
        status.setPersistentEffects("hylotlprotection", {
            {stat = "physicalResistance", baseMultiplier = 1.20},
            {stat = "perfectBlockLimit", amount = 2},
            {stat = "maxHealth", baseMultiplier = 1.25}
        })
        inWater = 1
	else
        isDry()
    end
end

function isDry()
    local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if not world.liquidAt(mouthPosition) then
        status.clearPersistentEffects("hylotlprotection")
	    inWater = 0
	end
end

function uninit()
    status.clearPersistentEffects("hylotlprotection")
end
