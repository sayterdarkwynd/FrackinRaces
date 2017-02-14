function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  effect.addStatModifierGroup({
    {stat = "fumudslowImmunity", amount = 1 },
    {stat = "jungleslowImmunity", amount = 1 },
    {stat = "spiderwebImmunity", amount = 1 },
    {stat = "sandstormImmunity", amount = 1 },
    {stat = "snowslowImmunity", amount = 1 },
    {stat = "slushslowImmunity", amount = 1 },
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "physicalResistance", amount = 0},
    {stat = "fireResistance", amount = -0.5},
    {stat = "iceResistance", amount = 0.2},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0.2},
    {stat = "shadowResistance", amount = 0.2}  
  })

if (world.type() == "garden") or (world.type() == "forest") or (world.type() == "arboreal") or (world.type() == "rainforest") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "powerMultiplier", baseMultiplier = 1.10},
	      {stat = "maxHealth", baseMultiplier = 1.15}
	    })
end  

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

function update(dt)
  if status.isResource("food") then
    self.foodValue = status.resource("food")
  else
    self.foodValue = 35
  end
  
  self.foodValue = (self.foodValue / 4.25)/100
  mcontroller.controlModifiers({ speedModifier = 1 + math.max(0.1, self.foodValue)})
end

function uninit()
  status.clearPersistentEffects("jungleEpic")
end