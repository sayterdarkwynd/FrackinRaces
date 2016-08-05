function init()
  effect.addStatModifierGroup({{stat = "grit", amount = 0.5}})
  effect.addStatModifierGroup({{stat = "energyRegenBlockTime", amount = 1.25}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.02,
			airJumpModifier = 1.04
		})
end

function uninit()
  
end