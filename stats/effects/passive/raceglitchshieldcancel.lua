function init()
  self.playedSound = 0
end

function activateVisualEffects()
  animator.setParticleEmitterOffsetRegion("sparks", mcontroller.boundBox())
  animator.setParticleEmitterActive("sparks", true)	
end

function update(dt)
  if self.playedSound == 0 then
	  animator.playSound("bolt")
	  status.clearPersistentEffects("glitchparotection")
	  status.clearPersistentEffects("shieldBonus") 
	  status.clearPersistentEffects("shieldBonus2") 
	  activateVisualEffects()
	  self.playedSound = 1
  end
end



function uninit()

end