function init()
  self.movementParams = mcontroller.baseParameters()  
  local bounds = mcontroller.boundBox()
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  self.tickDamagePercentage = 0.005
  self.tickTime = 2
  self.tickTimer = self.tickTime
  script.setUpdateDelta(5)
  self.species = world.entitySpecies(entity.id())
end

function update(dt)
	 if status.stat("isHerbivore")==1 or status.stat("isRobot")==1 then
	   world.sendEntityMessage(entity.id(), "queueRadioMessage", "foodtype")
	   if (self.tickTimer <= 0) then
	      self.tickTimer = self.tickTime
	      status.applySelfDamageRequest({
		damageType = "IgnoresDef",
		damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 1,
		damageSourceKind = "poison",
		sourceEntityId = entity.id()
	      })
	      mcontroller.controlModifiers({ airJumpModifier = 0.08, speedModifier = 0.08 })         
	      effect.setParentDirectives("fade=806e4f="..self.tickTimer * 0.25) 
	   else
	     self.tickTimer = self.tickTimer - dt
	   end
	 elseif status.stat("isCarnivore") or status.stat("isOmnivore") then
	   applyEffects()  
	 else
	   effect.expire()   
	 end
end

function applyEffects()
    status.setPersistentEffects("floranpower1", {
      {stat = "protection", amount = self.protectionBonus},
      {stat = "maxHealth", amount = baseValue },
      {stat = "maxEnergy", amount = baseValue2 }
    })
end

function uninit()
  status.clearPersistentEffects("floranpower1")
end