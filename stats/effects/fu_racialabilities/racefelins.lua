function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isCarnivore", amount = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance")},
    {stat = "electricResistance", amount = config.getParameter("electricResistance")},
    {stat = "fireResistance", amount = config.getParameter("fireResistance")},
    {stat = "iceResistance", amount = config.getParameter("iceResistance")},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance")},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance")},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance")},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance")},
    {stat = "fallDamageMultiplier", effectiveMultiplier = 0.40}
  })
  
  
  
	if (world.type() == "jungle") or (world.type() == "thickjungle") or (world.type() == "alien") or (world.type() == "protoworld") or (world.type() == "arboreal") or (world.type() == "arborealdark") then
		    status.setPersistentEffects("felinEpic", {
		      {stat = "protection", baseMultiplier = 1.05},
		      {stat = "maxEnergy", baseMultiplier = 1.10}
		    })
	end 
	
  script.setUpdateDelta(10)
  
end

function update(dt)
	mcontroller.controlModifiers({
			speedModifier = 1.06,
			airJumpModifier = 1.12
		})
end

function uninit()
  status.clearPersistentEffects("felinEpic")
end