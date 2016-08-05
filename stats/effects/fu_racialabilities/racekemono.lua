function init()
  effect.addStatModifierGroup({{stat = "shieldRegen", amount = 2}})
  effect.addStatModifierGroup({{stat = "perfectBlockLimitRegen", amount = 1}})
  effect.addStatModifierGroup({{stat = "foodDelta", amount = -0.062}})	
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end

function update(dt)
		mcontroller.controlModifiers({
				 speedModifier = 1.05,
				airJumpModifier = 1.05
			})
end

function uninit()
  
end