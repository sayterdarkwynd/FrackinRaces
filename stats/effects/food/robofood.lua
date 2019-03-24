function init()
  self.movementParams = mcontroller.baseParameters()  
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = (config.getParameter("healthBonus",0)*(status.resourceMax("health"))-status.resourceMax("health"))
  baseValue2 = (config.getParameter("energyBonus",0)*(status.resourceMax("energy"))-status.resourceMax("energy"))
  self.tickDamagePercentage = 0.005
  self.tickTime = 2
  self.tickTimer = self.tickTime
  script.setUpdateDelta(5)
  self.species = world.entitySpecies(entity.id())
  if not status.stat("isRobot")==1 or not self.species=="radien" or not self.species=="mantizi" then
    world.sendEntityMessage(entity.id(), "queueRadioMessage", "foodtype")
  end    
end

function update(dt)
	 if status.stat("isRobot")==1 or status.stat("isRadien")==1 or status.stat("isMantizi")==1 then
	     applyEffects()
	 else
	   if (self.tickTimer <= 0) then 
	     applyPenalty() 
	   else 
	     self.tickTimer = self.tickTimer - dt 
	   end
	 end
end



function applyPenalty()
      self.tickTimer = self.tickTime
      status.applySelfDamageRequest({
	damageType = "IgnoresDef",
	damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 1,
	damageSourceKind = "poison",
	sourceEntityId = entity.id()
      })
      effect.setParentDirectives("fade=806e4f="..self.tickTimer * 0.25) 
	status.removeEphemeralEffect("wellfed")
	if status.resourcePercentage("food") > 0.85 then status.setResourcePercentage("food", 0.85) end
end

function applyEffects()
    status.setPersistentEffects("glitchpower1", {
      {stat = "protection", amount = self.protectionBonus},
      {stat = "maxHealth", amount = baseValue },
      {stat = "maxEnergy", amount = baseValue2 },
      {stat = "fallDamageMultiplier", baseMultiplier = 0.85}
    })
end

function uninit()
  status.clearPersistentEffects("glitchpower1")
end