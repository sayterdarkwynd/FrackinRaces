require("/scripts/vec2.lua")

function init()
inWater=0
effect.addStatModifierGroup({{stat = "protection", amount = 7}})
effect.addStatModifierGroup({{stat = "waterbreathProtection", amount = 1}})
effect.addStatModifierGroup({{stat = "breathProtection", amount = 1}})
effect.addStatModifierGroup({{stat = "poisonStatusImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "beestingImmunity", amount = 1}})

baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})
  
script.setUpdateDelta(5)

end

function isDry()
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if not world.liquidAt(mouthPosition) then
            status.clearPersistentEffects("glitchweaken")
            status.clearPersistentEffects("glitchweaken2")
            status.clearPersistentEffects("glitchweaken3")
	    inWater = 0
	end
end

function update(dt)
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))

local mouthful = world.liquidAt(mouthposition)
local summationForDebug = ""

if mouthful then 
summationForDebug = "Liq:" .. mouthful .. "/" .. inWater
else 
summationForDebug = "Liq:nil/" .. inWater 
end
world.debugText(summationForDebug,{mouthPosition[1]-(string.len(summationForDebug)*0.25),mouthPosition[2]},"red")

	if world.liquidAt(mouthPosition) and inWater == 0 then
            status.setPersistentEffects("glitchweaken", {{stat = "protection", amount = -5}})
            status.setPersistentEffects("glitchweaken2", {{stat = "maxHealth", amount = -10}})
            status.setPersistentEffects("glitchweaken3", {{stat = "maxEnergy", amount = -20}})
	    inWater = 1
	else
	  isDry()
        end 
end

function uninit()
              status.clearPersistentEffects("glitchweaken")
              status.clearPersistentEffects("glitchweaken2")
              status.clearPersistentEffects("glitchweaken3")
end