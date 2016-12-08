function init()
  effect.addStatModifierGroup({
    {stat = "foodDelta", baseMultiplier = 1.06146},
    {stat = "slimestickImmunity", amount = 1},
    {stat = "slimefrictionImmunity", amount = 1},
    {stat = "physicalResistance", amount = 1},
    {stat = "fireResistance", amount = 1},
    {stat = "iceResistance", amount = 1},
    {stat = "electricResistance", amount = 1},
    {stat = "poisonResistance", amount = 1}        
  })

  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }}) 
  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
		mcontroller.controlModifiers({
				 speedModifier = 1.12
			})
end

function uninit()
  
end