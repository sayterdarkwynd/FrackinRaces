function init()
  effect.addStatModifierGroup({{stat = "invulnerable", amount = 1}})
  effect.addStatModifierGroup({
      {stat = "maxHealth", baseMultiplier = 1.05},
      {stat = "maxEnergy", baseMultiplier = 1.05}
    })
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
end

function update(dt)
  mcontroller.controlModifiers({speedModifier = 1.15})
end