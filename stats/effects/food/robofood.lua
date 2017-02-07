function init()
  --animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  --animator.setParticleEmitterActive("drips", true)
  
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  baseValue3 = config.getParameter("fallBonus",0)*(status.stat("fallDamageMultiplier"))
  isGlitchx= 0
  isNot=0
 
   baseValue4 = config.getParameter("healthPenalty",0)*(status.resourceMax("health"))
   baseValue5 = config.getParameter("energyPenalty",0)*(status.resourceMax("energy"))
   self.protectionBonus2 = config.getParameter("protectionPenalty", 0) 
   
  self.tickDamagePercentage = 0.010
  self.tickTime = 1.0
  self.tickTimer = self.tickTime
  

if world.entitySpecies(entity.id()) == "glitch" then
  isGlitchx=1
  applyEffects()
else
  isGlitchx=0
  applyEffects()
end

  script.setUpdateDelta(5)
end

function update(dt)

  self.tickTimer = self.tickTimer - dt
  
  if self.tickTimer <= 0 then
    self.tickTimer = self.tickTime
    if isNot >= 1 then
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 1,
        damageSourceKind = "poison",
        sourceEntityId = entity.id()
      })
      effect.setParentDirectives("fade=806e4f="..self.tickTimer * 0.4)
    end
  end
end

function applyEffects()
  if isGlitchx==1 then
            status.setPersistentEffects("glitchpower1", {
              {stat = "protection", amount = self.protectionBonus},
              {stat = "maxHealth", amount = baseValue },
              {stat = "maxEnergy", amount = baseValue2 },
              {stat = "fallDamageMultiplier", amount = baseValue3}
            })
            isGlitchx=2
  elseif isGlitchx==0 then
	    status.setPersistentEffects("noglitch1", {
	        {stat = "protection", amount = self.protectionBonus2},
	        {stat = "maxHealth", amount = baseValue4 },
	        {stat = "maxEnergy", amount = baseValue5 }
	      })
            isGlitchx=0
            isNot=1
  end

end

function uninit()
            status.clearPersistentEffects("glitchpower1")
            status.clearPersistentEffects("noglitch1")
end