function init()
  effect.addStatModifierGroup({{stat = "grit", amount = 0.4 }})
  effect.addStatModifierGroup({{stat = "jungleslowImmunity", amount = 1 }})
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue }})
  

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end

function update(dt)
		mcontroller.controlModifiers({
				speedModifier = 1.14
			})
end

function uninit()
  
end