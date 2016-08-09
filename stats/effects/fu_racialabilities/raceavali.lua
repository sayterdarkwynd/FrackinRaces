function init()
  effect.addStatModifierGroup({{stat = "snowslowImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "biomecoldImmunity", amount = 1}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
    if mcontroller.falling() then
      mcontroller.controlParameters(config.getParameter("fallingParameters"))
      mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed")))
    end
    mcontroller.controlModifiers({
	speedModifier = 1.05,
	airJumpModifier = 1.05
    })
end

function uninit()
  
end