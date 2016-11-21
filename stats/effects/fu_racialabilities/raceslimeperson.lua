function init()
  effect.addStatModifierGroup({{stat = "poisonStatusImmunity", amount = 1 }})
  effect.addStatModifierGroup({{stat = "slimeImmunity", amount = 1 }})
  effect.addStatModifierGroup({{stat = "slimestickImmunity", amount = 1 }})
  effect.addStatModifierGroup({{stat = "webstickImmunity", amount = 1 }})
  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", baseMultiplier = 0.15}})
  
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  
  self.gritBoost = config.getParameter("gritBonus",0)
  effect.addStatModifierGroup({{stat = "grit", baseMultiplier = self.gritBoost }}) 
  self.shieldBoost = config.getParameter("shieldBoost",0)
  effect.addStatModifierGroup({{stat = "shieldRegen", baseMultiplier = self.shieldBoost }})
  self.movementParams = mcontroller.baseParameters()  
  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end


function isDry()
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
status.setPersistentEffects("glitchpower", {{stat = "protection", amount = 4}})
	if not world.liquidAt(mouthPosition) then
            status.clearPersistentEffects("glitchweaken")
            status.clearPersistentEffects("glitchweaken2")
            status.clearPersistentEffects("glitchweaken3")
	    inWater = 0
	end
end

function update(dt)
		mcontroller.controlModifiers({
				speedModifier = 0.85
			})

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
            status.setPersistentEffects("glitchweaken", {{stat = "protection", amount = -5}})
            status.setPersistentEffects("glitchweaken2", {{stat = "maxHealth", amount = -20}})
            status.setPersistentEffects("glitchweaken3", {{stat = "maxEnergy", amount = -30}})
	    inWater = 1
	else
	  isDry()
        end 			
end

function uninit()
              status.clearPersistentEffects("glitchpower")
              status.clearPersistentEffects("glitchweaken")
              status.clearPersistentEffects("glitchweaken2")
              status.clearPersistentEffects("glitchweaken3")  
end