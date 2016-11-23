function init()
  self.powerModifier = config.getParameter("powerModifier", 0)
  effect.addStatModifierGroup({{stat = "powerMultiplier", baseMultiplier = 1.0 + self.powerModifier}})
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})   
  effect.addStatModifierGroup({{stat = "poisonStatusImmunity", amount = 1}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
    if (world.type() == "savannah") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "powerMultiplier", baseMultiplier = 1.10}
	    })
    end     
end

function update(dt)

end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end