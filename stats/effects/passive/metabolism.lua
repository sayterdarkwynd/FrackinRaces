function init()
	metabolismDelta=effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 1.06146}})
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
  if world.entitySpecies(entity.id()) == "apex" then
		mcontroller.controlModifiers({
				speedModifier = 1.08,
				airJumpModifier = 1.15
			})
  else
  		mcontroller.controlModifiers({
  				speedModifier = 1.11,
  				airJumpModifier = 1.15
			})
  end
end

function uninit()
	effect.removeStatModifierGroup(metabolismDelta)
end