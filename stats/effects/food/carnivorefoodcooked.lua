function init()

  self.tickDamagePercentage = 0.005
  self.tickTime = 5.0
  self.tickTimer = self.tickTime  

  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
  
end



function update(dt)

 if world.entitySpecies(entity.id()) == "floran" then
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

  effect.setParentDirectives("fade=ffea55="..self.tickTimer * 0.4)
  
  
  mcontroller.controlModifiers({
      speedModifier = 0.80,
      airJumpModifier = 0.80
    })
end

function uninit()

end