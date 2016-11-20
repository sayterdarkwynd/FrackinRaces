function init()
effect.addStatModifierGroup({{stat = "shieldStaminaRegen", amount = 0.4}})
effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 1.06146}})
effect.addStatModifierGroup({{stat = "slimestickImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "slimefrictionImmunity", amount = 1}})

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }}) 
  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
		mcontroller.controlModifiers({
				 speedModifier = 1.12
			})
end

function uninit()
  
end