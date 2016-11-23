function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }}) 
  effect.addStatModifierGroup({{stat = "electricStatusImmunity", amount = 1}})
  
    if (world.type() == "thickjungle") or (world.type() == "forest") or (world.type() == "tundra") or (world.type() == "garden") or (world.type() == "arboreal") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 1.10},
	      {stat = "maxEnergy", baseMultiplier = 1.10}
	    })
    end   
end

function update(dt)

end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end