require "/scripts/status.lua"
function init()
    self.listener = damageListener("damageTaken", function(note)
        suffer = note[1]["damageDealt"]
        source = note[1]["damageSourceKind"]
        if source == "frozenburning" or source == "ice" or source == "iceaxe" or source == "icebarrier" or source == "icebow" or source == "icebroadsword" or source == "icedagger" or source == "icehammer" or source == "iceplasma" or source == "iceplasmabullet" or source == "iceplasmashotgun" or source == "iceshortsword" or source == "icespear" then
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