function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  
  effect.addStatModifierGroup({{stat = "maxBreath", amount = 1100}})
  effect.addStatModifierGroup({{stat = "breathRegenerationRate", amount = 60}})
  effect.addStatModifierGroup({{stat = "wetImmunity", amount = 1}})  
  effect.addStatModifierGroup({{stat = "poisonStatusImmunity", amount = 1}})  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
	if (world.type() == "bog") or (world.type() == "swamp") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "powerMultiplier", baseMultiplier = 1.20}
		    })
	end    
end

function update(dt)

end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end