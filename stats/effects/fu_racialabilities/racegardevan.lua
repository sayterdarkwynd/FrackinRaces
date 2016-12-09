function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  self.healthRatio = 1
  local bounds = mcontroller.boundBox()
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "electricStatusImmunity", amount = 1},
    {stat = "poisonStatusImmunity", amount = 1},
    {stat = "biooozeImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -1},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0}
  })

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

    mcontroller.controlModifiers({
	speedModifier = 1.08
    })
    
end

function uninit()

end












