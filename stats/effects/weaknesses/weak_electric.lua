require "/scripts/status.lua"
function init()
    self.listener = damageListener("damageTaken", function(note)
        suffer = note[1]["damageDealt"]
        source = note[1]["damageSourceKind"]
        if source == "electric" or source == "electricbarrier" or source == "electricbow" or source == "electricbroadsword" or source == "electricaxe" or source == "electricdagger" or source == "electrichammer" or source == "electricplasma" or source == "electricplasmabullet" or source == "electricplasmashotgun" or source == "electricshortsword" or source == "electricspear"  then
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