function init()
  self.movementParams = mcontroller.baseParameters()
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  self.tickDamagePercentage = 0.01
  self.tickTime = 2
  self.tickTimer = self.tickTime
  script.setUpdateDelta(5)
  self.species = world.entitySpecies(entity.id())
  if (status.stat("isHerbivore")==1 or status.stat("isRobot")==1 or status.stat("isOmnivore")==1 or status.stat("isSugar")==1) and (not(status.stat("isRadien")==1)) then
    world.sendEntityMessage(entity.id(), "queueRadioMessage", "foodtyperad")
  end
  self.species = world.entitySpecies(entity.id())
end

function update(dt)
	 if self.species == "radien" or self.species == "novakid" or self.species == "thelusian" then
	   applyEffects()
	 else
	   if not self.species == "radien" and (self.tickTimer <= 0) then
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
      mcontroller.controlModifiers({ airJumpModifier = 0.08, speedModifier = 0.08 })    
end

function applyEffects()
    status.setPersistentEffects("floranpower1", { {stat = "healthRegen", amount = 0.8},{stat = "foodDelta", effectiveMultiplier = -1.08} })
    --radiens dont get full when near these plants. eat up!
    self.foodValue = status.resourcePercentage("food")
    status.removeEphemeralEffect("wellfed")
    if status.resourcePercentage("food") > 0.99 then status.setResourcePercentage("food", 0.99) end    
end

function uninit()
  status.clearPersistentEffects("floranpower1")
end
