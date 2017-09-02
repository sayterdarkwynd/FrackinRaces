function init()
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isOmnivore", amount = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
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
    {stat = "foodDelta", baseMultiplier = 1.06146},
    {stat = "slimestickImmunity", amount = 1},
    {stat = "slimefrictionImmunity", amount = 1}
  })
  
  local bounds = mcontroller.boundBox()
	if (world.type() == "forest") or (world.type() == "thickjungle") or (world.type() == "arboreal") or (world.type() == "arborealdark") then
		    status.setPersistentEffects("vieraEpic", {
		      {stat = "protection", baseMultiplier = 1.10},
		      {stat = "maxEnergy", baseMultiplier = 1.15}
		    })
		    mcontroller.controlModifiers( { speedModifier = 1.18 } )		    
	end  
  script.setUpdateDelta(10)
end

function update(dt)
  mcontroller.controlModifiers({ speedModifier = 1.12 }) 			
end

function uninit()
  status.clearPersistentEffects("vieraEpic")
end