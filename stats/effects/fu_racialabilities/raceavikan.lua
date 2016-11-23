function init()
effect.addStatModifierGroup({{stat = "fireStatusImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "biomeheatImmunity", amount = 1}})
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  
  
  script.setUpdateDelta(0)

	if (world.type() == "desert") or (world.type() == "desertwastes") or (world.type() == "desertwastesdark") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "powerMultiplier", baseMultiplier = 1.10},
		      {stat = "maxHealth", baseMultiplier = 1.15}
		    })
	end  
	
end

function update(dt)

end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end