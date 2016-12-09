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

	--Human
	if world.entitySpecies(entity.id()) == "human" then
		status.addEphemeralEffect("racehuman",math.huge)
	end
	
	--Avian
	if world.entitySpecies(entity.id()) == "avian" then
		status.addEphemeralEffect("raceavian",math.huge)
		status.addEphemeralEffect("hpedge",math.huge)
		--status.addEphemeralEffect("weak_ice",math.huge)
	end

	--Apex
	if world.entitySpecies(entity.id()) == "apex" then
	       status.addEphemeralEffect("raceapex",math.huge)
	       status.addEphemeralEffect("metabolism",math.huge)
	       --status.addEphemeralEffect("weak_electric",math.huge)
	end
	
	--Floran
	if world.entitySpecies(entity.id()) == "floran" then
		status.addEphemeralEffect("racefloran",math.huge)
		status.addEphemeralEffect("starvingedge",math.huge)
		--status.addEphemeralEffect("weak_fire",math.huge)
		status.addEphemeralEffect("lightregenfloran",math.huge)
		
	end
	
	--Hylotl
	if world.entitySpecies(entity.id()) == "hylotl" then
		status.addEphemeralEffect("racehylotl",math.huge)
		status.addEphemeralEffect("swimboost2",math.huge)
		--status.addEphemeralEffect("weak_electric",math.huge)
	end
	
	--Glitch
	if world.entitySpecies(entity.id()) == "glitch" then
		status.addEphemeralEffect("raceglitch",math.huge)
		status.addEphemeralEffect("attrition",math.huge)
		--status.addEphemeralEffect("weak_electric",math.huge)
	end
	
	--Novakid
	if world.entitySpecies(entity.id()) == "novakid" then
		status.addEphemeralEffect("racenovakid",math.huge)
		status.addEphemeralEffect("foodregennovakid",math.huge)
		--status.addEphemeralEffect("weak_poison",math.huge)
	end


	--avali
	if world.entitySpecies(entity.id()) == "avali" then
		status.addEphemeralEffect("raceavali",math.huge)
	end
	
	--avikan
	if world.entitySpecies(entity.id()) == "avikan" then
		status.addEphemeralEffect("raceavikan",math.huge)
		--status.addEphemeralEffect("weak_ice",math.huge)
	end
	
	--peglaci
	if world.entitySpecies(entity.id()) == "peglaci" then
		status.addEphemeralEffect("racepeglaci",math.huge)
	end
	
	--felins
	if world.entitySpecies(entity.id()) == "felin" then
		status.addEphemeralEffect("racefelins",math.huge)
		--status.addEphemeralEffect("weak_fire",math.huge)
	end		
	
	--Orcana
	if world.entitySpecies(entity.id()) == "orcana" then
		status.addEphemeralEffect("raceorcana",math.huge)
		status.addEphemeralEffect("swimboost3",math.huge)
		--status.addEphemeralEffect("weak_fire",math.huge)
	end

	--Munari
	if world.entitySpecies(entity.id()) == "munari" then
	        status.addEphemeralEffect("racemunari",math.huge)
	        --status.addEphemeralEffect("weak_electric",math.huge)
		status.addEphemeralEffect("swimboost2",math.huge)
	end

	--Bunnykin
	if world.entitySpecies(entity.id()) == "bunnykin" then
	        status.addEphemeralEffect("racebunnykin",math.huge)
	end
	
	--ponex 
	if world.entitySpecies(entity.id()) == "ponex" then
		status.addEphemeralEffect("raceponex",math.huge)
	end
	
	--viera (bunny people)
	if world.entitySpecies(entity.id()) == "viera" then
		status.addEphemeralEffect("raceviera",math.huge)
		status.addEphemeralEffect("weak_shadow",math.huge)
	end	

	--fenerox (fox people)
	if world.entitySpecies(entity.id()) == "fenerox" then
		status.addEphemeralEffect("racefenerox",math.huge)
		status.addEphemeralEffect("darkregenfenerox",math.huge)
		status.addEphemeralEffect("darkhunter",math.huge)
		status.addEphemeralEffect("metabolismfenerox",math.huge)
		--status.addEphemeralEffect("weak_fire",math.huge)
	end	
	
	--kineptic (mage cats)
	if world.entitySpecies(entity.id()) == "kineptic" then
		status.addEphemeralEffect("racekineptic",math.huge)
		status.addEphemeralEffect("darkregenfenerox",math.huge)
	end
	
	--vespoid (bug people)
	if world.entitySpecies(entity.id()) == "vespoid" then
          status.addEphemeralEffect("racevespoid",math.huge)
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
	
	--sergal (cat/fox/hybrid ...thing)
	if world.entitySpecies(entity.id()) == "sergal" then
	  status.addEphemeralEffect("racesergal",math.huge)
	end	

	--vulpes (fox people)
	if world.entitySpecies(entity.id()) == "vulpes" then
          status.addEphemeralEffect("racevulpes",math.huge)
          --status.addEphemeralEffect("weak_fire",math.huge)
	end	
	
	--kemono (fox people)
	if world.entitySpecies(entity.id()) == "kemono" then
          status.addEphemeralEffect("racekemono",math.huge)
          status.addEphemeralEffect("weak_shadow",math.huge)
	end	
	
	--ningen  
	if world.entitySpecies(entity.id()) == "ningen" then
          status.addEphemeralEffect("raceningen",math.huge)
	end

	--argonian  
	if world.entitySpecies(entity.id()) == "argonian" then
          status.addEphemeralEffect("raceargonian",math.huge)
          status.addEphemeralEffect("metabolismargonian",math.huge)
          status.addEphemeralEffect("swimboost1",math.huge)
          --status.addEphemeralEffect("weak_ice",math.huge)
	end

	--Nightar
	if world.entitySpecies(entity.id()) == "nightar" then
		status.addEphemeralEffect("racenightar",math.huge)
		status.addEphemeralEffect("novakidglow",math.huge)
	end	

	--Slimeperson
	if world.entitySpecies(entity.id()) == "slimeperson" then
		status.addEphemeralEffect("raceslimeperson",math.huge)
		
	end
	--Lamia
	if world.entitySpecies(entity.id()) == "lamia" then
		status.addEphemeralEffect("racelamia",math.huge)
		--status.addEphemeralEffect("weak_ice",math.huge)
	end	
	--Gardevan
	if world.entitySpecies(entity.id()) == "gardevan" then
		status.addEphemeralEffect("racegardevan",math.huge)
		--status.addEphemeralEffect("weak_fire",math.huge)
		status.addEphemeralEffect("lighthunter",math.huge)
		status.addEphemeralEffect("lightregenfloran",math.huge)
		
	end
	--Wasp Hive
	if world.entitySpecies(entity.id()) == "wasphive" then
		status.addEphemeralEffect("racewasphive",math.huge)
		--status.addEphemeralEffect("weak_fire",math.huge)
		--status.addEphemeralEffect("weak_ice",math.huge)
	end
	--Elunite
	if world.entitySpecies(entity.id()) == "elunite" then
		status.addEphemeralEffect("raceelunite",math.huge)
		status.addEphemeralEffect("weak_shadow",math.huge)
	end
	--Skelekin
	if world.entitySpecies(entity.id()) == "skelekin" then
		status.addEphemeralEffect("raceskelekin",math.huge)
		--status.addEphemeralEffect("weak_fire",math.huge)
	end
	--Gyrusen
	if world.entitySpecies(entity.id()) == "gyrusen" then
		status.addEphemeralEffect("racegyrusen",math.huge)
		--status.addEphemeralEffect("weak_ice",math.huge)
	end
	
	--Kazdra
	if world.entitySpecies(entity.id()) == "kazdra" then
		status.addEphemeralEffect("racekazdra",math.huge)
		--status.addEphemeralEffect("weak_ice",math.huge)
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