function init()
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "fireStatusImmunity", amount = 1 },
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "foodDelta", baseMultiplier = 0.6},
    {stat = "protection", amount = 2 },
    {stat = "physicalResistance", amount = 0.15},
    {stat = "fireResistance", amount = 0.5},
    {stat = "iceResistance", amount = -0.5},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0}  
  })
  self.healthRatio = 1
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  self.timer = 2
  
if (world.type() == "volcanic") or (world.type() == "magma") or (world.type() == "magmadark") or (world.type() == "desert") or (world.type() == "mountainous") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "protection", baseMultiplier = 1.10},
	      {stat = "maxHealth", baseMultiplier = 1.15}
	    })
end 
if (world.type() == "snow") or (world.type() == "arctic") or (world.type() == "arcticdark") or (world.type() == "tundra") or (world.type() == "icewaste") or (world.type() == "icewastedark")  or (world.type() == "icemoon") or (world.type() == "nitrogensea") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "protection", baseMultiplier = 0.80},
	      {stat = "maxHealth", baseMultiplier = 0.80}
	    })
end 

end


function update(dt)
 self.timer = self.timer - dt
 if status.statPositive("maxHealth") then 
   self.healthRatio = status.resource("health") / status.stat("maxHealth") 
 else 
   self.healthRatio = 0 
 end
 
 if self.timer <= 0 then
  if self.healthRatio < 0.50 then
    local configBombDrop = { power = 3 }
    world.spawnProjectile("firefinish", mcontroller.position(), entity.id(), {0, 0}, false, configBombDrop)       
  end
  self.timer=2
 end
  
end

function uninit()
    status.clearPersistentEffects("jungleEpic")
end