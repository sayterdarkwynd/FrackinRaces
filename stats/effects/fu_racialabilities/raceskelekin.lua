function init()
  self.powerModifier = config.getParameter("powerModifier", 0)
  effect.addStatModifierGroup({{stat = "powerMultiplier", amount = self.powerModifier}})
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }})  
  
  effect.addStatModifierGroup({{stat = "protection", amount = 2 }})
  effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 0.001}})
  
  effect.addStatModifierGroup({{stat = "poisonStatusImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "electricStatusImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "biomecoldImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "biomeradiationImmunity", amount = 1}})
  self.healingRate = 1
  script.setUpdateDelta(5)
end

function isDry()
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if not world.liquidAt(mouthPosition) then
            status.clearPersistentEffects("liquideffect")
	    inWater = 0
	end
end

function update(dt)
  local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))  
  
 	if (world.liquidAt(mouthPosition)) and (inWater == 1) and (mcontroller.liquidId()== 7) or (mcontroller.liquidId()== 55) or (mcontroller.liquidId()== 40) or (mcontroller.liquidId()== 60) then
  	  self.healingRate = 0.015
	  status.modifyResourcePercentage("health", self.healingRate * dt)
	elseif (world.liquidAt(mouthPosition)) and (inWater == 0) and (mcontroller.liquidId()== 7) or (mcontroller.liquidId()== 55) or (mcontroller.liquidId()== 40) or (mcontroller.liquidId()== 60) then
	    status.addEphemeralEffect("regenerationminor",math.huge)
	    status.setPersistentEffects("liquideffect", {  -- milk, alien juice , blood and darkwater are good for Skelekins
	      {stat = "maxHealth", baseMultiplier = 1.25},
	      {stat = "maxEnergy", baseMultiplier = 1.25},
	      {stat = "fallDamageMultiplier", amount = 0.0}
	    })
	    inWater = 1
	elseif (world.liquidAt(mouthPosition)) and (inWater == 1) and (mcontroller.liquidId()== 6) then
  	  self.healingRate = 0.015
	  status.modifyResourcePercentage("health", -self.healingRate * dt)	
	elseif (world.liquidAt(mouthPosition)) and (inWater == 0) and (mcontroller.liquidId()== 6) then
	    status.addEphemeralEffect("regenerationminor",math.huge)
	    status.setPersistentEffects("liquideffect", {  -- healingwater is bad for Skelekins
	      {stat = "maxHealth", baseMultiplier = 0.85},
	      {stat = "maxEnergy", baseMultiplier = 0.85},
	      {stat = "protection", baseMultiplier = 0.85}
	    })
	    inWater = 1
	else
	  isDry()
	end  
	
end

function uninit()
   status.clearPersistentEffects("liquideffect")
end