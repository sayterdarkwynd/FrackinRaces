function init()
  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
  
  script.setUpdateDelta(5)

  self.tickDamagePercentage = 0.010
  self.tickTime = 1.0
  self.tickTimer = self.tickTime
end

function update(dt)
  self.tickTimer = self.tickTimer - dt
  if not world.entitySpecies(entity.id()) == "glitch"  then
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
  else
            status.setPersistentEffects("glitchpower1", {{stat = "protection", amount = 5}})
            status.setPersistentEffects("glitchpower2", {{stat = "maxHealth", amount = 10}})
            status.setPersistentEffects("glitchpower3", {{stat = "maxEnergy", amount = 20}})    
  end
  
end

function uninit()
            status.clearPersistentEffects("glitchpower1")
            status.clearPersistentEffects("glitchpower2")
            status.clearPersistentEffects("glitchpower3")
end