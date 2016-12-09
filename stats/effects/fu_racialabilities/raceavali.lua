function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "snowslowImmunity", amount = 1},
    {stat = "biomecoldImmunity", amount = 1},
    {stat = "iceStatusImmunity", amount = 1}
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.75},
    {stat = "iceResistance", amount = 0.9},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0}  
  })
 
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
	if mcontroller.falling() then
	  mcontroller.controlParameters(config.getParameter("fallingParameters"))
	  mcontroller.setYVelocity(math.max(mcontroller.yVelocity(), config.getParameter("maxFallSpeed")))
	end
	mcontroller.controlModifiers({
	  speedModifier = 1.09,
	  airJumpModifier = 1.09
	})

	if (world.windLevel(mcontroller.position()) >= 70 ) then
		mcontroller.controlModifiers({
		  speedModifier = 1.12,
		  airJumpModifier = 1.12
		})
	elseif (world.windLevel(mcontroller.position()) >= 7 ) then
		mcontroller.controlModifiers({
		  speedModifier = 1.15,
		  airJumpModifier = 1.20
		})
	end
end

function uninit()
  
end