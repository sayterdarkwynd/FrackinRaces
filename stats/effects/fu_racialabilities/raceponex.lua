function init()
  effect.addStatModifierGroup({
    {stat = "honeyslowImmunity", amount = 1},
    {stat = "grit", amount = 0.3},
    {stat = "beestingImmunity", amount = 1},
    {stat = "physicalResistance", amount = 1},
    {stat = "fireResistance", amount = -1.75},
    {stat = "iceResistance", amount = 1},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = 1}  
  })

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