function init()
  self.powerModifier = config.getParameter("powerModifier", 0)
  effect.addStatModifierGroup({
    {stat = "insanityImmunity", amount = 1},
    {stat = "powerMultiplier", amount = self.powerModifier},
    {stat = "fallDamageMultiplier", effectiveMultiplier = 0.50},
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.80},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0}     
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