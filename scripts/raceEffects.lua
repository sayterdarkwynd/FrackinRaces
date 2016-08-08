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
	end

	--Apex
	if world.entitySpecies(entity.id()) == "apex" then
	       status.addEphemeralEffect("raceapex",math.huge)
	       status.addEphemeralEffect("metabolism",math.huge)
	end
	
	--Floran
	if world.entitySpecies(entity.id()) == "floran" then
		status.addEphemeralEffect("racefloran",math.huge)
		status.addEphemeralEffect("starvingedge",math.huge)
		status.addEphemeralEffect("lightregenfloran",math.huge)
		
	end
	
	--Hylotl
	if world.entitySpecies(entity.id()) == "hylotl" then
		status.addEphemeralEffect("racehylotl",math.huge)
		status.addEphemeralEffect("swimboost2",math.huge)
	end
	
	--Glitch
	if world.entitySpecies(entity.id()) == "glitch" then
		status.addEphemeralEffect("raceglitch",math.huge)
		status.addEphemeralEffect("attrition",math.huge)
	end
	
	--Novakid
	if world.entitySpecies(entity.id()) == "novakid" then
		status.addEphemeralEffect("racenovakid",math.huge)
		status.addEphemeralEffect("foodregennovakid",math.huge)
	end


	--avali
	if world.entitySpecies(entity.id()) == "avali" then
		status.addEphemeralEffect("raceavali",math.huge)
	end
	
	--avikan
	if world.entitySpecies(entity.id()) == "avikan" then
		status.addEphemeralEffect("raceavikan",math.huge)
	end
	
	--peglaci
	if world.entitySpecies(entity.id()) == "peglaci" then
		status.addEphemeralEffect("racepeglaci",math.huge)
	end
	
	--felins
	if world.entitySpecies(entity.id()) == "felin" then
		status.addEphemeralEffect("racefelins",math.huge)
	end		
	
	--Orcana
	if world.entitySpecies(entity.id()) == "orcana" then
		status.addEphemeralEffect("raceorcana",math.huge)
		status.addEphemeralEffect("swimboost2",math.huge)
	end

	--Munari
	if world.entitySpecies(entity.id()) == "munari" then
	        status.addEphemeralEffect("raceorcana",math.huge)
		status.addEphemeralEffect("swimboost2",math.huge)
	end
	
	--ponex 
	if world.entitySpecies(entity.id()) == "ponex" then
		status.addEphemeralEffect("raceponex",math.huge)
	end
	
	--viera (bunny people)
	if world.entitySpecies(entity.id()) == "viera" then
		status.addEphemeralEffect("raceviera",math.huge)
	end	

	--fenerox (fox people)
	if world.entitySpecies(entity.id()) == "fenerox" then
		status.addEphemeralEffect("racefenerox",math.huge)
		status.addEphemeralEffect("darkregenfenerox",math.huge)
		status.addEphemeralEffect("metabolism",math.huge)
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
	
	--inkling    already has racial abilities in its own native mod. no need for this.
	--if world.entitySpecies(entity.id()) == "inkling" then
	--  status.addEphemeralEffect("raceinkling",math.huge)
        --  status.addEphemeralEffect("swimboost1",math.huge)
	--end	
	
	--vulpes (fox people)
	if world.entitySpecies(entity.id()) == "vulpes" then
          status.addEphemeralEffect("racevulpes",math.huge)
	end	
	
	--kemono (fox people)
	if world.entitySpecies(entity.id()) == "kemono" then
          status.addEphemeralEffect("racekemono",math.huge)
	end	
	
	--ningen  (exact same as fucking humans)
	if world.entitySpecies(entity.id()) == "ningen" then

	end
	
	--LLL (wolves  , Locus Les Loupes)
	if world.entitySpecies(entity.id()) == "loupes" then

	end		
	
	--mephetor (skunk)
	if world.entitySpecies(entity.id()) == "mephetor" then
        
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