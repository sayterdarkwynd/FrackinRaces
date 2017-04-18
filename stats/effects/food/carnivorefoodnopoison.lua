function init()
  self.movementParams = mcontroller.baseParameters()  
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  self.protectionBonus2 = config.getParameter("protectionPenalty", 0) 
  script.setUpdateDelta(5)
end

function update(dt)
  if world.entitySpecies(entity.id()) == "floran" or world.entitySpecies(entity.id()) == "felin" then
    applyEffects()
  end
end

function applyEffects()
  if world.entitySpecies(entity.id()) == "floran" or world.entitySpecies(entity.id()) == "felin" then
            status.setPersistentEffects("floranpower1", {
              {stat = "protection", amount = self.protectionBonus},
              {stat = "maxHealth", amount = baseValue },
              {stat = "maxEnergy", amount = baseValue2 }
            })
  end
end

function uninit()
  status.clearPersistentEffects("floranpower1")
end