function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isOmnivore", baseMultiplier = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    --{stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    {stat = "protection", baseMultiplier = config.getParameter("defenseBonus")},
    --{stat = "fallDamageMultiplier", baseMultiplier = config.getParameter("fallBonus")},
    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance")},
    {stat = "electricResistance", amount = config.getParameter("electricResistance")},
    {stat = "fireResistance", amount = config.getParameter("fireResistance")},
    {stat = "iceResistance", amount = config.getParameter("iceResistance")},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance")},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance")},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance")},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance")},
    {stat = "maxBreath", amount = 1100},
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