function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  
  self.gritBoost = config.getParameter("gritBonus",0)
  effect.addStatModifierGroup({{stat = "grit", baseMultiplier = self.gritBoost }})  
  
  local bounds = mcontroller.boundBox()
  effect.addStatModifierGroup({{stat = "biomeradiationImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "ffextremeradiationImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "fireStatusImmunity", amount = 1}})
  script.setUpdateDelta(5)
end

function update(dt)
		mcontroller.controlModifiers({
			   speedModifier = 1.05
			})
end

function uninit()

end