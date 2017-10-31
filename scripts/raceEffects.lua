require("/scripts/vec2.lua")
local fuoldInit = init
local fuoldUpdate = update
local fuoldUninit = uninit

function init()
    fuoldInit()
    self.lastYPosition = 0
    self.lastYVelocity = 0
    self.fallDistance = 0
    self.raceConfig = root.assetJson("/scripts/raceEffects.config")
    local bounds = mcontroller.boundBox() --Mcontroller for movement
end

function update(dt)
    fuoldUpdate(dt)

    local racial = self.raceConfig[world.entitySpecies(entity.id())]

	-- Add the magic racial ability status effect
	if racial then
		status.addEphemeralEffect("raceability",math.huge)

        -- Add any other special effects
        if racial.special then
            for _,thing in pairs(racial.special) do
                status.addEphemeralEffect(thing,math.huge)
            end
        end
	end

    local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
    if status.statPositive("breathProtection") or world.breathable(mouthPosition)
        or status.statPositive("waterbreathProtection") and world.liquidAt(mouthPosition)
        then
        status.modifyResource("breath", status.stat("breathRegenerationRate") * dt)
    else
        status.modifyResource("breath", -status.stat("breathDepletionRate") * dt)
    end
end
