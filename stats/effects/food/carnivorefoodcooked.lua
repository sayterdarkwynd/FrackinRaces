function init()
  self.movementParams = mcontroller.baseParameters()  
  local bounds = mcontroller.boundBox()
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  self.tickDamagePercentage = 0.01
  self.tickTime = 2
  self.tickTimer = self.tickTime 
  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
 
  checkRace()
  script.setUpdateDelta(5)
end

function update(dt)
  
end

function applyEffects()
    status.setPersistentEffects("floranpower1", {
      {stat = "protection", amount = self.protectionBonus},
      {stat = "maxHealth", amount = baseValue },
      {stat = "maxEnergy", amount = baseValue2 }
    })
end

function checkRace()  -- are we carnivorous or omnivorous? customize per effect
  if (world.entitySpecies(entity.id()) == "floran") 
  or (world.entitySpecies(entity.id()) == "felin") 
  or (world.entitySpecies(entity.id()) == "fenerox") 
  or (world.entitySpecies(entity.id()) == "orcana")  
  or (world.entitySpecies(entity.id()) == "ponex") 
  or (world.entitySpecies(entity.id()) == "kazdra") 
  or (world.entitySpecies(entity.id()) == "vespoid") 
  or (world.entitySpecies(entity.id()) == "lamia") 
  or (world.entitySpecies(entity.id()) == "callistan") then
    applyEffects()
  else
    self.isNot = 1
  end
end

function uninit()
    status.clearPersistentEffects("floranpower1")
end