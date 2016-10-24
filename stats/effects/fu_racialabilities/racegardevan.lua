function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  effect.addStatModifierGroup({{stat = "maxHealth", amount = baseValue }})
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({{stat = "maxEnergy", amount = baseValue2 }}) 
  effect.addStatModifierGroup({{stat = "electricStatusImmunity", amount = 1}})
  local bounds = mcontroller.boundBox()
  self.healthRatio = 1
  effect.addStatModifierGroup({{stat = "poisonStatusImmunity", amount = 1}})
  effect.addStatModifierGroup({{stat = "biooozeImmunity", amount = 1}})
  script.setUpdateDelta(220)
end

function update(dt)

 if status.statPositive("maxHealth") then 
   self.healthRatio = status.resource("health") / status.stat("maxHealth") 
 else 
   self.healthRatio = 0 
 end

  if self.healthRatio < 0.75 then
    local configBombDrop = { power = 0 }
    world.spawnProjectile("grassseeds2", mcontroller.position(), entity.id(), {0, 0}, false, configBombDrop)       
  end

end

function uninit()

end












