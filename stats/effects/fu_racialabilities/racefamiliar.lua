function init()
effect.addStatModifierGroup({{stat = "maxBreath", amount = 200.0}})
effect.addStatModifierGroup({{stat = "biooozeImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "webstickimmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "spiderwebImmunity", amount = 1}})
effect.addStatModifierGroup({{stat = "blacktarImmunity", amount = 1}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	mcontroller.controlModifiers({
	   speedModifier = 1.05
	})
end

function uninit()
  
end