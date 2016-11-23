function init()
  effect.addStatModifierGroup({{stat = "fumudslowImmunity", amount = 1 }})
  effect.addStatModifierGroup({{stat = "jungleslowImmunity", amount = 1 }})
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue }})  

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
	if (world.type() == "jungle") or (world.type() == "thickjungle") or (world.type() == "alien") or (world.type() == "protoworld") or (world.type() == "arboreal") or (world.type() == "arborealdark") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "protection", baseMultiplier = 1.10},
		      {stat = "maxHealth", baseMultiplier = 1.15}
		    })
	end  
end

function update(dt)

end

function uninit()
    status.clearPersistentEffects("jungleEpic")
end