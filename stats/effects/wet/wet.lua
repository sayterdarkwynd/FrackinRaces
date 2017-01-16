function init()
  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
  
  -- floran buff
  self.healingRate = 0.005
  script.setUpdateDelta(5)
end

function update(dt)

	if world.entitySpecies(entity.id()) == "floran" then
	  self.healingRate = 0.001
	  self.foodRate = 0.001
	  status.modifyResourcePercentage("health", self.healingRate * dt)
          status.modifyResourcePercentage("food", self.foodRate * dt)
	end
	
end

function uninit()
  
end
