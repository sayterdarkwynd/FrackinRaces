require "/scripts/status.lua"
function init()
    self.listener = damageListener("damageTaken", function(note)
        suffer = note[1]["damageDealt"]
        source = note[1]["damageSourceKind"]
        if source == "shadow" or source == "fushadowdamage" then
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