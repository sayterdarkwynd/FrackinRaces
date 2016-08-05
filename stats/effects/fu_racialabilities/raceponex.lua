function init()
  effect.addStatModifierGroup({{stat = "honeyslowImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "grit", amount = 0.3}})
  effect.addStatModifierGroup({{stat = "beestingImmunity", amount = 1}})	
  local bounds = mcontroller.boundBox()	
  script.setUpdateDelta(10)
end

function update(dt)
		mcontroller.controlModifiers({
				 speedModifier = 1.25
			})
end

function uninit()
  
end