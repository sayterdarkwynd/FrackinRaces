require("/scripts/vec2.lua")
function init()
  inWater=0
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  
  
  effect.addStatModifierGroup({{stat = "maxBreath", amount = 1500}})
  effect.addStatModifierGroup({{stat = "breathRegenerationRate", amount = 60}})
  effect.addStatModifierGroup({{stat = "wetImmunity", amount = 1}})
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

local mouthful = world.liquidAt(mouthposition)
 local summationForDebug = "Liq:" .. mouthful .. "/" .. inWater

 

world.debugText(summationForDebug,{mouthPosition[1]-(string.len(summationForDebug)*0.25),mouthPosition[2]},"red")

	if world.liquidAt(mouthPosition) and inWater == 0 then
            status.setPersistentEffects("hylotlprotection", {{stat = "protection", amount = 9}})
            status.setPersistentEffects("hylotlprotection2", {{stat = "perfectBlockLimit", amount = 2}})
            status.setPersistentEffects("hylotlprotection3", {{stat = "maxHealth", amount = 20}})
            status.setPersistentEffects("hylotlprotection4", {{stat = "fallDamageMultiplier", amount = 0.0}})
	    inWater = 1
	     

	else
	  isDry()
        end 
end

function uninit()
              status.clearPersistentEffects("hylotlprotection")
              status.clearPersistentEffects("hylotlprotection2")
              status.clearPersistentEffects("hylotlprotection3")
            status.clearPersistentEffects("hylotlprotection4")
end