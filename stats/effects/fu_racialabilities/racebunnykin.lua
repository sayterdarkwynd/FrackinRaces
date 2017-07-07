function init()

  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isHerbivore", baseMultiplier = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    --{stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    --{stat = "protection", baseMultiplier = config.getParameter("defenseBonus")},
    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance")},
    {stat = "electricResistance", amount = config.getParameter("electricResistance")},
    {stat = "fireResistance", amount = config.getParameter("fireResistance")},
    {stat = "iceResistance", amount = config.getParameter("iceResistance")},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance")},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance")},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance")},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance")},
    {stat = "slimestickImmunity", amount = 1},
    {stat = "jungleslowImmunity", amount = 1 },
    {stat = "fumudslowImmunity", amount = 1 },    
    {stat = "foodDelta", baseMultiplier = 1.06146}
  })

    if (world.type() == "forest") or (world.type() == "tundra") or (world.type() == "garden") or (world.type() == "snow") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 1.10},
	      {stat = "maxEnergy", baseMultiplier = 1.20}
	    })
    end  
    
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.18,
			airJumpModifier = 1.20
		})
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end

















function init()

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },

    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0.3},
    {stat = "electricResistance", amount = -0.4},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0} 
  })  

    if (world.type() == "forest") or (world.type() == "tundra") or (world.type() == "garden") or (world.type() == "snow") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 1.10},
	      {stat = "maxEnergy", baseMultiplier = 1.10}
	    })
    end  
    
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.18,
			airJumpModifier = 1.20
		})
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end