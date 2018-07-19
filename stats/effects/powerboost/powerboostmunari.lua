function init()
  munariPower=effect.addStatModifierGroup({
      {stat = "maxHealth", baseMultiplier = 1.05},
      {stat = "maxEnergy", baseMultiplier = 1.05}
    })
  script.setUpdateDelta(5)
end

function update(dt)
  mcontroller.controlModifiers({speedModifier = 1.15})
end

function uninit()
	status.removeStatModifierGroup(munariPower)
end