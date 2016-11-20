require "/scripts/status.lua"
function init()
    self.listener = damageListener("damageTaken", function(note)
        suffer = note[1]["damageDealt"]
        source = note[1]["damageSourceKind"]
        if source == "poison" or source == "poisonaxe" or source == "poisonbarrier" or source == "poisonbow" or source == "poisonbullet" or source == "poisonbroadsword" or source == "poisondagger" or source == "poisonhammer" or source == "poisonlash" or source == "poisonplasma" or source == "poisonplasmabullet" or source == "poisonplasmashotgun" or source == "poisonshortsword" or source == "poisonspear" then
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