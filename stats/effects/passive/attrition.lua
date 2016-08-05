function init()
  effect.addStatModifierGroup({{stat = "foodDelta", amount = -0.03}})
  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", amount = 1.15}})
  script.setUpdateDelta(5)
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 0.90
		})
end


function uninit()
  
end