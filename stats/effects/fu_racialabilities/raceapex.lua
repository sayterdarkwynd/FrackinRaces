function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({
    {stat = "fumudslowImmunity", amount = 1 },
    {stat = "jungleslowImmunity", amount = 1 },
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0.25},
    {stat = "electricResistance", amount = -0.75},
    {stat = "poisonResistance", amount = 0}  
  })

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
	if (world.type() == "jungle") or (world.type() == "thickjungle") or (world.type() == "alien") or (world.type() == "protoworld") or (world.type() == "arboreal") or (world.type() == "arborealdark") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "protection", baseMultiplier = 1.10},
		      {stat = "maxHealth", baseMultiplier = 1.15}
		    })
	end  
end

function update(dt)

end

function uninit()
    status.clearPersistentEffects("jungleEpic")
end