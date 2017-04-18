function init()
  self.movementParams = mcontroller.baseParameters()  
  local bounds = mcontroller.boundBox()
  
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  baseValue3 = config.getParameter("fallBonus",0)*(status.stat("fallDamageMultiplier"))
 
  self.protectionBonus2 = config.getParameter("protectionPenalty", 0) 
  self.tickDamagePercentage = 0.010
  self.tickTime = 2
  self.tickTimer = self.tickTime

  if (world.entitySpecies(entity.id()) == "floran") or (world.entitySpecies(entity.id()) == "felin") then
    applyEffects()
  else
    self.isNot = 1
  end
  
  script.setUpdateDelta(5)
end

function update(dt)
  if not (world.entitySpecies(entity.id()) == "floran") or (world.entitySpecies(entity.id()) == "felin") then
    if (self.tickTimer <= 0) then
      self.tickTimer = self.tickTime
      status.applySelfDamageRequest({
	damageType = "IgnoresDef",
	damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 1,
	damageSourceKind = "poison",
	sourceEntityId = entity.id()
      })
      mcontroller.controlModifiers({
	airJumpModifier = 0.08,
	speedModifier = 0.08
      })      
      effect.setParentDirectives("fade=806e4f="..self.tickTimer * 0.4)
    end    
  end
  self.tickTimer = self.tickTimer - dt
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