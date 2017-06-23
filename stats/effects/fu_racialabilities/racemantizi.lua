function init()
  
  effect.addStatModifierGroup({
    {stat = "grit", amount = 0.3},
    {stat = "electricStatusImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0.20},
    {stat = "fireResistance", amount = -0.3},
    {stat = "iceResistance", amount = -0.2},
    {stat = "electricResistance", amount = 0.2},
    {stat = "poisonResistance", amount = 0.2},
    {stat = "shadowResistance", amount = 0} 
  })

    if (world.type() == "sulphuric") or (world.type() == "sulphuricdark") or (world.type() == "sulphuricocean") or (world.type() == "sulphuricoceanfloor") or (world.type() == "jungle") or (world.type() == "desert") or (world.type() == "desertwastes") or (world.type() == "desertwastesdark") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "protection", baseMultiplier = 1.10},
	      {stat = "maxEnergy", baseMultiplier = 1.10}
	    })
    end  
    
end

function update(dt)
  
end

function uninit()
  
end