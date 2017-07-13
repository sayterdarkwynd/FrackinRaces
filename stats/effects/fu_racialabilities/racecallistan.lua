function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")

    effect.addStatModifierGroup({
	    -- base Attributes
	    {stat = "isCarnivore", amount = 1},
	    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
	    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
	    {stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
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
	    --other
	    {stat = "foodDelta", baseMultiplier = 0.60},
	    {stat = "fumudslowImmunity", amount = 1 },
	    {stat = "jungleslowImmunity", amount = 1 },
	    {stat = "spiderwebImmunity", amount = 1 },
	    {stat = "sandstormImmunity", amount = 1 },
	    {stat = "snowslowImmunity", amount = 1 },
	    {stat = "slushslowImmunity", amount = 1 }	    
    })  


	if (world.type() == "garden") or (world.type() == "forest") or (world.type() == "arboreal") or (world.type() == "rainforest") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "powerMultiplier", baseMultiplier = 1.10},
		      {stat = "maxHealth", baseMultiplier = 1.15}
		    })
	end  

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
  if status.isResource("food") then
    self.foodValue = status.resource("food")
  else
    self.foodValue = 35
  end
  
  self.foodValue = (self.foodValue / 4.25)/100
  mcontroller.controlModifiers({ speedModifier = 1 + math.max(0.1, self.foodValue)})
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end