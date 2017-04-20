function init()
  self.powerModifier = config.getParameter("powerModifier", 0)
  effect.addStatModifierGroup({
    {stat = "insanityImmunity", amount = 1},
    {stat = "fallDamageMultiplier", effectiveMultiplier = 0.40},
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.40},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0}     
  })

	if (world.type() == "jungle") or (world.type() == "thickjungle") or (world.type() == "alien") or (world.type() == "protoworld") or (world.type() == "arboreal") or (world.type() == "arborealdark") then
		    status.setPersistentEffects("felinEpic", {
		      {stat = "protection", amount = 2},
		      {stat = "maxHealth", baseMultiplier = 1.10}
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