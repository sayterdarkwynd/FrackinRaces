function init()
  self.movementParams = mcontroller.baseParameters()  
  local bounds = mcontroller.boundBox()
  
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  isFloranx= 0
  isNot=0
 
  self.protectionBonus2 = config.getParameter("protectionPenalty", 0) 

  script.setUpdateDelta(5)
end

function update(dt)
	if world.entitySpecies(entity.id()) == "floran" then
	  isFloranx=1
	  applyEffects()
	else
	  isFloranx=0
	  applyEffects()
	end
end

function applyEffects()
  if world.entitySpecies(entity.id()) == "floran" then
            status.setPersistentEffects("floranpower1", {
              {stat = "protection", amount = self.protectionBonus},
              {stat = "maxHealth", amount = baseValue },
              {stat = "maxEnergy", amount = baseValue2 }
            })
            isFloranx=2
  else
    isFloranx=2
    isNot=1
  end
end

function uninit()
            status.clearPersistentEffects("floranpower1")
end




















function init()
  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
  
  script.setUpdateDelta(5)

  self.tickDamagePercentage = 0.010
  self.tickTime = 1.0
  self.tickTimer = self.tickTime
end

function update(dt)

  if not world.entitySpecies(entity.id()) == "floran"  then
  
  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = self.tickTime
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 1,
        damageSourceKind = "poison",
        sourceEntityId = entity.id()
      })
  end

  effect.setParentDirectives("fade=00AA00="..self.tickTimer * 0.4)
  
  end
  
end

function uninit()
  
end