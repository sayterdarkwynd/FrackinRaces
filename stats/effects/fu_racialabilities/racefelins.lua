function init()
  self.powerModifier = config.getParameter("powerModifier", 0)
  effect.addStatModifierGroup({
    {stat = "insanityImmunity", amount = 1},
    {stat = "powerMultiplier", amount = self.powerModifier},
    {stat = "fallDamageMultiplier", effectiveMultiplier = 0.50},
    {stat = "physicalResistance", amount = 1},
    {stat = "fireResistance", amount = -1.80},
    {stat = "iceResistance", amount = 1},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = 1}     
  })

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.07,
			airJumpModifier = 1.15
		})
end

function uninit()
  
end