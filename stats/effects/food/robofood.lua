function init()
  
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  baseValue3 = config.getParameter("fallBonus",0)*(status.stat("fallDamageMultiplier"))
  self.tickDamagePercentage = 0.008
  self.tickTime = 2
  self.tickTimer = self.tickTime
  script.setUpdateDelta(5)
end

function applyEffects()
    status.setPersistentEffects("glitchpower1", {
      {stat = "protection", amount = self.protectionBonus},
      {stat = "maxHealth", baseMultiplier = baseValue },
      {stat = "maxEnergy", baseMultiplier = baseValue2 },
      {stat = "fallDamageMultiplier", baseMultiplier = baseValue3}
    })
end

function update(dt)
	 if not status.stat("isRobot")>0 or not self.species=="novakid" then
	   world.sendEntityMessage(entity.id(), "queueRadioMessage", "foodtype")
	   if (self.tickTimer <= 0) then
	      self.tickTimer = self.tickTime
	      status.applySelfDamageRequest({
		damageType = "IgnoresDef",
		damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 1,
		damageSourceKind = "poison",
		sourceEntityId = entity.id()
	      })
	      effect.setParentDirectives("fade=806e4f="..self.tickTimer * 0.4) 
	   else
	     self.tickTimer = self.tickTimer - dt
	   end
	 else 
	    applyEffects()   
	 end
end

function uninit()
  status.clearPersistentEffects("glitchpower1")
end