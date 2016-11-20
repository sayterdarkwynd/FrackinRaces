function init()
effect.addStatModifierGroup({{stat = "shieldStaminaRegen", amount = 0.4}})
effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 1.06146}})
effect.addStatModifierGroup({{stat = "slimestickImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "slimefrictionImmunity", amount = 1}})
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