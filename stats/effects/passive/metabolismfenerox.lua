function init()
  metabolismDelta=effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 1.06346}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
		mcontroller.controlModifiers({
				speedModifier = 1.06,
				airJumpModifier = 1.11
			})
end

function uninit()
  effect.removeStatModifierGroup(metabolismDelta)
end