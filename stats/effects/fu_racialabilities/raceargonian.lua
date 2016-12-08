function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "maxBreath", amount = 1100},
    {stat = "breathRegenerationRate", amount = 60},
    {stat = "wetImmunity", amount = 1},
    {stat = "poisonStatusImmunity", amount = 1},
    {stat = "physicalResistance", amount = 1},
    {stat = "fireResistance", amount = 1},
    {stat = "iceResistance", amount = -2},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = 2} 
  })
  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
	if (world.type() == "bog") or (world.type() == "swamp") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "powerMultiplier", baseMultiplier = 1.20}
		    })
	end    
end

function update(dt)

end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end