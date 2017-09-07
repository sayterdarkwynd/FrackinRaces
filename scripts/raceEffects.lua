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

	--[[
	--Floran
	if world.entitySpecies(entity.id()) == "floran" then
		status.addEphemeralEffect("racefloran",math.huge)
		status.addEphemeralEffect("starvingedgefloran",math.huge)
		status.addEphemeralEffect("lightregenfloran",math.huge)

	end

	--Hylotl
	if world.entitySpecies(entity.id()) == "hylotl" then
		status.addEphemeralEffect("racehylotl",math.huge)
		status.addEphemeralEffect("swimboost2",math.huge)
	end

	--Novakid
	if world.entitySpecies(entity.id()) == "novakid" then
		status.addEphemeralEffect("racenovakid",math.huge)
		status.addEphemeralEffect("foodregennovakid",math.huge)
	end

	--Orcana
	if world.entitySpecies(entity.id()) == "orcana" then
		status.addEphemeralEffect("raceorcana",math.huge)
		status.addEphemeralEffect("swimboost3",math.huge)
	end

	--Munari
	if world.entitySpecies(entity.id()) == "munari" then
	        status.addEphemeralEffect("racemunari",math.huge)
		status.addEphemeralEffect("swimboost2",math.huge)
	end

	--fenerox (fox people)
	if world.entitySpecies(entity.id()) == "fenerox" then
		status.addEphemeralEffect("racefenerox",math.huge)
		status.addEphemeralEffect("darkregenfenerox",math.huge)
	end

	--kineptic (mage cats)
	if world.entitySpecies(entity.id()) == "kineptic" then
		status.addEphemeralEffect("racekineptic",math.huge)
		status.addEphemeralEffect("darkregenfenerox",math.huge)
	end

	--familiar (stuffed animal type things)
	if world.entitySpecies(entity.id()) == "familiar" then
	  status.addEphemeralEffect("racefamiliar",math.huge)
	  status.addEphemeralEffect("familiarglow",math.huge)
	end

	--neko (cat girls)
	if world.entitySpecies(entity.id()) == "neko" then
          status.addEphemeralEffect("raceneko",math.huge)
          status.addEphemeralEffect("novakidglow",math.huge)
	end

	--argonian
	if world.entitySpecies(entity.id()) == "argonian" then
          status.addEphemeralEffect("raceargonian",math.huge)
          status.addEphemeralEffect("swimboost1",math.huge)
	end

	--Nightar
	if world.entitySpecies(entity.id()) == "nightar" then
		status.addEphemeralEffect("racenightar",math.huge)
		status.addEphemeralEffect("nightarglow3",math.huge)
		status.addEphemeralEffect("darkhunternightar",math.huge)
	end

	--Gardevan
	if world.entitySpecies(entity.id()) == "gardevan" then
		status.addEphemeralEffect("racegardevan",math.huge)
		status.addEphemeralEffect("lighthunter",math.huge)
		status.addEphemeralEffect("lightregenfloran",math.huge)

	end]]

    local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
    if status.statPositive("breathProtection") or world.breathable(mouthPosition)
	   or status.statPositive("waterbreathProtection") and world.liquidAt(mouthPosition)
	      then
        status.modifyResource("breath", status.stat("breathRegenerationRate") * dt)
    else
        status.modifyResource("breath", -status.stat("breathDepletionRate") * dt)
    end
end
