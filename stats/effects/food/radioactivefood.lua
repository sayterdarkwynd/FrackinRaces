function init()
  self.movementParams = mcontroller.baseParameters()
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)
  baseValue2 = config.getParameter("energyBonus",0)
  self.tickDamagePercentage = 0.01
  self.tickTime = 2
  self.tickTimer = self.tickTime
  script.setUpdateDelta(5)
  self.species = world.entitySpecies(entity.id())
  if (status.stat("isHerbivore")==1 or status.stat("isRobot")==1 or status.stat("isOmnivore")==1 or status.stat("isSugar")==1) and (not(status.stat("isOmnivore")==1 and status.stat("isCarnivore")==1)) then
    world.sendEntityMessage(entity.id(), "queueRadioMessage", "foodtype")
  end
  status.clearPersistentEffects("floranpower1")
  self.species = world.entitySpecies(entity.id())
end

function update(dt)
	 if self.species == "radien" or self.species == "novakid" then
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
      mcontroller.controlModifiers({ airJumpModifier = 0.08, speedModifier = 0.08 })
      effect.setParentDirectives("fade=806e4f="..self.tickTimer * 0.25)
	status.removeEphemeralEffect("wellfed")
	if status.resourcePercentage("food") > 0.85 then status.setResourcePercentage("food", 0.85) end
end

function applyEffects()
    status.setPersistentEffects("floranpower1", {
      {stat = "healthRegen", amount = 0.5},
      {stat = "maxHealth", baseMultiplier = baseValue },
      {stat = "maxEnergy", baseMultiplier = baseValue }
    })
end

function uninit()

end
