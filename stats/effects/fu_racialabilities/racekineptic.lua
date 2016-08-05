function init()
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = 40}})
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