function init()
  effect.addStatModifierGroup({
    {stat = "isCarnivore", amount = 1 },
    {stat = "honeyslowImmunity", amount = 1},
    {stat = "grit", amount = 0.3},
    {stat = "beestingImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.75},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = -1}  
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