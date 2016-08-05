function init()
  effect.addStatModifierGroup({{stat = "beestingImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "honeyslowImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "fallDamageMultiplier", effectiveMultiplier = 0.20}})
  local bounds = mcontroller.boundBox()	
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
	 speedModifier = 1.08,
	 stickyForce = 0.35,
	 airForce = 35.0,
	 liquidForce = 20.0
	})
end

function uninit()
  
end