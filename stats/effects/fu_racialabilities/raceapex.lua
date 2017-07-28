function init()
  effect.addStatModifierGroup({
    -- base Attributes
      {stat = "isOmnivore", amount = 1},
    --{stat = "maxHealth", baseMultiplier = config.getParameter("healthBonus")},
      {stat = "maxEnergy", baseMultiplier = config.getParameter("energyBonus")},
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
    
    -- other
    {stat = "foodDelta", baseMultiplier = 1.06146},
    {stat = "jungleslowImmunity", amount = 1 },
    {stat = "fumudslowImmunity", amount = 1 }
  })

    --Environment Bonus
    if (world.type() == "jungle") or (world.type() == "thickjungle") or (world.type() == "forest") or (world.type() == "snow") or (world.type() == "arboreal") or (world.type() == "arborealdark") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = config.getParameter("environmentBonusHealth",0)},
	      {stat = "maxEnergy", baseMultiplier = config.getParameter("environmentBonusEnergy",0)}
	    })
    end  
  self.basePower = status.stat("powerMultiplier")
  self.baseMaxEnergy = status.stat("maxEnergy")
  script.setUpdateDelta(10)
end

function update(dt)
 	-- check their existing health levels
	self.healthMin = status.resource("health")
	self.healthMax = status.stat("maxHealth")         
	
	-- range at which the effects start kicking in. 80% health?
	self.healthRange = (status.stat("maxHealth") * 0.8) 
	
	-- what percent of health remains?
	self.percentRate = self.healthMin / self.healthMax 
	
	--calculate core bonus
        self.powerMod = 2-self.percentRate / (self.healthRange / self.healthMax)

	-- other modifiers
        self.protectionMod = self.powerMod * 2
        self.critMod = self.powerMod * 5

        -- make sure it doesn't get wonky by setting limits
        if (self.powerMod) < 1 then
	  self.powerMod = 1
	elseif (self.powerMod) >= 1.3 then  -- max 30%
	  self.powerMod = 1.3
	elseif (self.protectionMod) >= 1.20 then  -- max 20%
	  self.protectionMod = 1.2
	elseif (self.critMod) >= 5 then  -- max 5
	  self.critMod = 5
	end
	

        -- apex lose energy but gain power as they take damage (and vice versa)
	if (self.healthMin >= self.healthMax) then
	  status.clearPersistentEffects("apexPower")   
	elseif (self.percentRate) <= (self.healthRange) then
	    status.setPersistentEffects("apexPower", {
	      {stat = "maxEnergy", baseMultiplier = self.percentRate },
	      {stat = "powerMultiplier", baseMultiplier = self.powerMod },
	      {stat = "protection", baseMultiplier = self.protectionMod },
	      {stat = "critChance", amount = self.critMod }
	    })	 
        end

        -- the apex gets speed and jump bonuses
	mcontroller.controlModifiers({
		speedModifier =  config.getParameter("speedBonus",0),
		airJumpModifier =  config.getParameter("jumpBonus",0)
	})
  
end

function uninit()
  status.clearPersistentEffects("apexPower")
  status.clearPersistentEffects("starvationpower")
  status.clearPersistentEffects("starvationpower2")
  status.clearPersistentEffects("jungleEpic")
end