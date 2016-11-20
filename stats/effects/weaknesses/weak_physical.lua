require "/scripts/status.lua"
function init()
    self.listener = damageListener("damageTaken", function(note)
        suffer = note[1]["damageDealt"]
        source = note[1]["damageSourceKind"]
        if source == "physical" or source == "slash" or source == "lash" or source == "dagger" or source == "broadsword" or source == "shortsword" or source == "spear" or source == "slash" or source == "axe" or source == "bow" or source == "bite" or source == "fiststrong" or source == "foldingchair" or source == "hammer" or or source == "fryingpan" or source == "sawblade" or source == "shotgunbullet" or source == "standardbullet" then
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