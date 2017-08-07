function init()

  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    {stat = "isOmnivore", amount = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    {stat = "fallDamageMultiplier", baseMultiplier = config.getParameter("fallBonus")},
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance")},
    {stat = "electricResistance", amount = config.getParameter("electricResistance")},
    {stat = "fireResistance", amount = config.getParameter("fireResistance")},
    {stat = "iceResistance", amount = config.getParameter("iceResistance")},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance")},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance")},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance")},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance")},
    {stat = "fireStatusImmunity", amount = 1},
    {stat = "grit", amount = 0.25},
    {stat = "sandstormImmunity", amount = 1},
    {stat = "quicksandImmunity", amount = 1}
  })
  
  script.setUpdateDelta(0)


    onColdWorld()
    onHotWorld()
	if self.isHot == 1 then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "protection", baseMultiplier = 1.05},
	      {stat = "maxHealth", baseMultiplier = 1.15},
	      {stat = "healthRegen", amount = 0.04}
	    })
	end  
	if self.isCold == 1 then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "energyRegenPercentageRate", baseMultiplier = 0.5}
	    })
	end  	
end


function onColdWorld()
  if (world.type() == "snow") or (world.type() == "arctic") or (world.type() == "arcticdark") or (world.type() == "icemoon") or (world.type() == "icewaste") or (world.type() == "icewastedark") then
    self.isCold = 1
  else
    self.isCold = 0
  end
end

function onHotWorld()
  if (world.type() == "scorchedcity") or (world.type() == "desert") or (world.type() == "desertwastes") or (world.type() == "desertwastesdark") or (world.type() == "magma") or (world.type() == "magmadark") or (world.type() == "volcanic") or (world.type() == "volcanicdark") then
    self.isHot = 1
  else
    self.isHot = 0
  end
end


function update(dt)	
	
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end