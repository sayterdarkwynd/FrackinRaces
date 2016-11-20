require "/scripts/status.lua"
function init()
self.listener = damageListener("damageTaken", function(note)
suffer = note[1]["damageDealt"]
source = note[1]["damageSourceKind"]
if source == "fire" then
status.modifyResource("health", -suffer * 2)
end
end)
script.setUpdateDelta(2)
end

function update(dt)
self.listener:update()
end

function uninit()
end



require "/scripts/status.lua"
function init()
    self.listener = damageListener("damageTaken", function(note)
        suffer = note[1]["damageDealt"]
        source = note[1]["damageSourceKind"]
        if source == "fire" or source == "heat" or source == "fireaxe" or source == "firebarrier" or source == "firebow" or source == "firebroadsword" or source == "firedagger" or source == "firehammer" or source == "fireplasma" or source == "fireplasmabullet" or source == "fireplasmashotgun" or source == "fireshortsword" or source == "firespear" or source == "flamethrower" then
          status.applySelfDamageRequest({
            damageType = "IgnoresDef",
            damage = suffer,
            sourceEntityId = entity.id()
            })
        end
    end)
  script.setUpdateDelta(1) 
end
 
function update()
self.listener:update()
end
 
function uninit()
end