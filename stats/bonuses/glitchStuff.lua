require("/scripts/vec2.lua")
--didit = false

function init()
    inWater = 0
    --[[self.species = world.entitySpecies(entity.id())
    if not self.species then return else didit = true end

    self.raceJson = root.assetJson("/scripts/raceEffects.config")
    self.specialConfig = self.raceJson[self.species].specialConfig
]]

    if not status.resource("energy") then -- make sure NPCs arent breaking this
        self.energyValue = 1
    end

    script.setUpdateDelta(10)
end

function update(dt)
    --if not didit then init() end
    -- does the player have more than 25% energy? if not, we apply a nasty penalty to protections
   self.energyValue = status.resource("energy") / status.stat("maxEnergy")

    if self.energyValue <= 0.25 then
        status.setPersistentEffects("glitchweaken", {
            {stat = "physicalResistance", amount = -0.2},
            {stat = "protection", baseMultiplier = status.stat("protection") * 0.5 }
        })
    else
        status.clearPersistentEffects("glitchweaken")
    end

    local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
    local mouthful = world.liquidAt(mouthposition)
    if (world.liquidAt(mouthPosition)) and (inWater == 0) and (mcontroller.liquidId()== 5) or (mcontroller.liquidId()== 44) or (mcontroller.liquidId()== 11) then
        status.setPersistentEffects("glitchliquid",
        {
            {stat = "maxEnergy", amount = 1.25 },
            {stat = "energyRegenPercentageRate", amount = 0.484 },
            {stat = "healthRegen", amount = 0.484 }
        })
        inWater = 1
        activateVisualEffects()
    else
        isDry()
    end
end

function isDry()
    local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if not world.liquidAt(mouthPosition) then
        status.clearPersistentEffects("glitchliquid")
	    inWater = 0
	    deactivateVisualEffects()
	end
end

function deactivateVisualEffects()
    animator.setParticleEmitterActive("sparks", false)
end

function activateVisualEffects()
    animator.setParticleEmitterOffsetRegion("sparks", mcontroller.boundBox())
    animator.setParticleEmitterActive("sparks", true)
end

function uninit()
    status.clearPersistentEffects("glitchshield")
    status.clearPersistentEffects("glitchweaken")
    status.clearPersistentEffects("glitchliquid")
end
