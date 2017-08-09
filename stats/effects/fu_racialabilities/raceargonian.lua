function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isCarnivore", amount = 1 },
    {stat = "isOmnivore", amount = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    --{stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    {stat = "protection", baseMultiplier = config.getParameter("defenseBonus")},
    --{stat = "fallDamageMultiplier", baseMultiplier = config.getParameter("fallBonus")},
    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance",0)},
    {stat = "electricResistance", amount = config.getParameter("electricResistance",0)},
    {stat = "fireResistance", amount = config.getParameter("fireResistance",0)},
    {stat = "iceResistance", amount = config.getParameter("iceResistance",0)},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance",0)},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance",0)},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance",0)},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance",0)},
    {stat = "maxBreath", amount = 1100},
    {stat = "foodDelta", baseMultiplier = 0.8},
    {stat = "poisonStatusImmunity", amount = 1}
  })
  
  local bounds = mcontroller.boundBox()
	if (world.type() == "bog") or (world.type() == "swamp") or (world.type() == "strangesea") then
		    status.setPersistentEffects("jungleEpic", {
		      {stat = "maxHealth", baseMultiplier = 1.25}
		    })
	end    
  script.setUpdateDelta(10)
end

function update(dt)
   self.healingRate = 1.00005 / 420
   status.modifyResourcePercentage("health", self.healingRate * dt)
   
	if (world.type() == "bog") or (world.type() == "swamp") then
		mcontroller.controlModifiers({
				speedModifier = 1.15
			})
	end    			
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end