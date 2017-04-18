function init()
  self.movementParams = mcontroller.baseParameters()  
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  self.protectionBonus2 = config.getParameter("protectionPenalty", 0) 
  
  if (world.entitySpecies(entity.id()) == "floran") or (world.entitySpecies(entity.id()) == "felin") then
    applyEffects()
  end
  
  script.setUpdateDelta(5)
end

function update(dt)

end

function applyEffects()
    status.setPersistentEffects("floranpower1", {
      {stat = "protection", amount = self.protectionBonus},
      {stat = "maxHealth", baseMultiplier = baseValue },
      {stat = "maxEnergy", baseMultiplier = baseValue2 }
    })
end

function uninit()
  status.clearPersistentEffects("floranpower1")
end