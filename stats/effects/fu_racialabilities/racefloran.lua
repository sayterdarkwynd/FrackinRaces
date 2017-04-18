function init()
  
  effect.addStatModifierGroup({
    {stat = "maxFood", amount = 30 },
    {stat = "electricStatusImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.5},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0.2},
    {stat = "shadowResistance", amount = 0} 
  })

    if (world.type() == "thickjungle") or (world.type() == "forest") or (world.type() == "tundra") or (world.type() == "garden") or (world.type() == "arboreal") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 1.10},
	      {stat = "maxEnergy", baseMultiplier = 1.10}
	    })
    end   
end

function update(dt)

end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end