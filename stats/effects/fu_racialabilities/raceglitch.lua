require("/scripts/vec2.lua")

function init()
inWater=0
effect.addStatModifierGroup({{stat = "poisonStatusImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "beestingImmunity", amount = 1}})

baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})
local bounds = mcontroller.boundBox()
script.setUpdateDelta(5)

end

function isDry()
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
status.setPersistentEffects("glitchpower", {{stat = "protection", amount = 2}})
	if not world.liquidAt(mouthPosition) then
            status.clearPersistentEffects("glitchweaken")
	    inWater = 0
	    deactivateVisualEffects()
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

	    status.clearPersistentEffects("glitchpower")
            status.setPersistentEffects("glitchweaken", 
            {
            {stat = "protection", amount = -5},
            {stat = "maxHealth", amount = -10},
            {stat = "maxEnergy", amount = -20},
            {stat = "enumbrance", amount = 1},
            {stat = "foodDelta", amount = -0.07}
            })
	    inWater = 1
	    activateVisualEffects()
	else
	  isDry()
        end 
end


function deactivateVisualEffects()
  animator.setParticleEmitterActive("sparks", false)	
end

function activateVisualEffects()
  animator.setParticleEmitterOffsetRegion("sparks", mcontroller.boundBox())
  animator.setParticleEmitterActive("sparks", true)	
end

function uninit()
              status.clearPersistentEffects("glitchpower")
              status.clearPersistentEffects("glitchweaken")
end