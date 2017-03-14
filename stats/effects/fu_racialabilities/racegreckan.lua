function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  self.healthRatio = 1
  local bounds = mcontroller.boundBox()
  underground = undergroundCheck()
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "erchiusImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0.15},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = -0.5},
    {stat = "poisonResistance", amount = 0.2},
    {stat = "poisonStatusImmunity", amount = 1},
    {stat = "shadowResistance", amount = 0.12}
  })

        if underground then 
		    status.setPersistentEffects("jungleEpic2", {
		      {stat = "maxHealth", baseMultiplier = 1.15}
		    })        
        end
        
	if (world.type() == "moon") or (world.type() == "moon_shadow") or (world.type() == "moon_toxic") or (world.type() == "moon_desert") or (world.type() == "moon_stone") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "protection", baseMultiplier = 1.10},
		      {stat = "maxHealth", baseMultiplier = 1.15}
		    })
	end  

  script.setUpdateDelta(10)
end

function undergroundCheck()
	return world.underground(mcontroller.position()) 
end

function update(dt)
        
        if underground then
		mcontroller.controlModifiers({
				speedModifier = 1.10,
				airJumpModifier = 1.10
			})        
        end
	if (world.type() == "moon") or (world.type() == "moon_shadow") or (world.type() == "moon_toxic") or (world.type() == "moon_desert") or (world.type() == "moon_stone") then
		mcontroller.controlModifiers({
				speedModifier = 1.15,
				airJumpModifier = 1.15
			})
	end      
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
  status.clearPersistentEffects("jungleEpic2")
end












