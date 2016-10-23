function init()
  effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 1.06146}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
		mcontroller.controlModifiers({
				speedModifier = 1.11,
				airJumpModifier = 1.15
			})
end

function uninit()
  
end