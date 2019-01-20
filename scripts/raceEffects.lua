require("/scripts/vec2.lua")
local fuoldInit = init
local fuoldUpdate = update
local fuoldUninit = uninit

function init()
    fuoldInit()
    self.lastYPosition = 0
    self.lastYVelocity = 0
    self.fallDistance = 0
    local bounds = mcontroller.boundBox() --Mcontroller for movement
end

function update(dt)
    fuoldUpdate(dt)
	
	if not self.species then
		self.species = world.entitySpecies(entity.id())
		local success
		success,self.racial = pcall(
			function () 
				return root.assetJson(string.format("/species/%s.raceeffect", self.species))
			end
		)
		if not success then self.racial = nil end 
	end

	-- Add the magic racial ability status effect
	if self.racial then
		status.addEphemeralEffect("raceability",math.huge)

        -- Add any other special effects
        if self.racial.special then
            for _,thing in pairs(self.racial.special) do
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
