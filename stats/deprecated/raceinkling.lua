require("/scripts/vec2.lua")
function init()
  inWater=0
  effect.addStatModifierGroup({{stat = "wetImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "foodDelta", amount = -0.049}})
  script.setUpdateDelta(5)
end

function isDry()
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if not world.liquidAt(mouthPosition) then
            status.clearPersistentEffects("hylotlprotection")
            status.clearPersistentEffects("hylotlprotection2")
            status.clearPersistentEffects("hylotlprotection3")
            status.clearPersistentEffects("hylotlprotection4")
	    inWater = 0
	end
end

function update(dt)
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if world.liquidAt(mouthPosition) and inWater == 0 then
            status.setPersistentEffects("hylotlprotection", {{stat = "foodDelta", amount = -0.025}})
            status.setPersistentEffects("hylotlprotection2", {{stat = "energyRegenBlockTime", amount = 1.2}})
            status.setPersistentEffects("hylotlprotection3", {{stat = "maxEnergy", amount = 12}})
            status.setPersistentEffects("hylotlprotection4", {{stat = "breathDepletionRate", amount = 1.5}})
	    inWater = 1
	else
	  isDry()
        end  
end

function uninit()
  
end