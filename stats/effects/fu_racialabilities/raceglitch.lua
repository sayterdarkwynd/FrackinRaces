require("/scripts/vec2.lua")

function init()
inWater=0
baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))

effect.addStatModifierGroup({
  {stat = "poisonStatusImmunity", amount = 1},
  {stat = "beestingImmunity", amount = 1},
  {stat = "maxHealth", amount = baseValue },
  {stat = "maxEnergy", amount = baseValue2 },
  {stat = "physicalResistance", amount = 0.15},
  {stat = "fireResistance", amount = 0},
  {stat = "iceResistance", amount = -0.25},
  {stat = "electricResistance", amount = -0.50},
  {stat = "poisonResistance", amount = 0.2},
  {stat = "shadowResistance", amount = 0} 
})

local bounds = mcontroller.boundBox()
script.setUpdateDelta(5)

end

function isDry()
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
status.setPersistentEffects("glitchpower", {{stat = "physicalResistance", baseMultiplier = 1.15}})
	if not world.liquidAt(mouthPosition) then
            status.clearPersistentEffects("glitchweaken")
	    inWater = 0
	    deactivateVisualEffects()
	end
end

function update(dt)
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
local mouthful = world.liquidAt(mouthposition)

	if (world.liquidAt(mouthPosition)) and (inWater == 0) and (mcontroller.liquidId()~= 5) then
	    status.clearPersistentEffects("glitchpower")
            status.setPersistentEffects("glitchweaken", 
            {
              {stat = "physicalResistance", amount = -1},
              {stat = "iceResistance", amount = -0.5},
              {stat = "fireResistance", amount = 0},
              {stat = "poisonResistance", amount = 0},
              {stat = "electricResistance", amount = -1.5},
              {stat = "maxHealth", amount = -10},
              {stat = "maxEnergy", amount = -20},
              {stat = "foodDelta", amount = -0.07}
            })
	    inWater = 1
	    activateVisualEffects()
	elseif (world.liquidAt(mouthPosition)) and (inWater == 0) and (mcontroller.liquidId()== 5) then
            status.setPersistentEffects("glitchweaken", 
            {
              {stat = "maxEnergy", amount = baseValue2 },
              {stat = "energyRegenPercentageRate", amount = 0.484 }
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