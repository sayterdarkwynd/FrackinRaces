function init()
  self.movementParams = mcontroller.baseParameters()  
  self.protectionBonus = config.getParameter("protectionBonus", 0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
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
  if status.stat("isCarnivore") then
    applyEffects()
  else
    self.isNot = 1
  end
end

function uninit()
  status.clearPersistentEffects("floranpower1")
end