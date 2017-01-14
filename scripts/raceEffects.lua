require("/scripts/vec2.lua")
local fuoldInit = init
local fuoldUpdate = update
local fuoldUninit = uninit

local config

function init()
  fuoldInit()
  self.lastYPosition = 0
  self.lastYVelocity = 0
  self.fallDistance = 0
  local bounds = mcontroller.boundBox() --Mcontroller for movement

  -- Load configuration
  config = root.assetJson("/scripts/raceEffects.config")
  if not config or not config.ephemeral then
    error("Frackin' Races: /scripts/raceEffects.config appears to be malformed.")
  end
end

function update(dt)
  fuoldUpdate(dt)

  local species = world.entitySpecies(entity.id())
  local raceEphemeralEffects = config.ephemeral[species]

  -- Apply ephemeral effects.
  if raceEphemeralEffects then
    for name, duration in pairs(raceEphemeralEffects) do
      if duration <= 0 then duration = math.huge end
      status.addEphemeralEffect(name, duration)
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

  status.removeEphemeralEffect("weak_fire")
  status.removeEphemeralEffect("weak_ice")
  status.removeEphemeralEffect("weak_poison")
  status.removeEphemeralEffect("weak_physical")
  status.removeEphemeralEffect("weak_shadow")
  status.removeEphemeralEffect("weak_electric")

end
