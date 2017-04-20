require("/scripts/vec2.lua")
function init()
  inWater=0
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "maxBreath", amount = 2000},
    {stat = "breathRegenerationRate", amount = 70},
    {stat = "wetImmunity", amount = 1},
    {stat = "physicalResistance", amount = 0.1},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = -0.35},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0} 
  })
  
  script.setUpdateDelta(5)	
  
    if (world.type() == "ocean") or (world.type() == "oceanfloor") or (world.type() == "tidewater") or (world.type() == "tidewaterfloor") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 1.10},
	      {stat = "maxEnergy", baseMultiplier = 1.20}
	    })
    end     
end

function isDry()
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if not world.liquidAt(mouthPosition) then
	    status.removeEphemeralEffect("regenerationminor",math.huge)
            status.clearPersistentEffects("orcanaprotection")
	    inWater = 0
	end
end

function update(dt)
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if (world.liquidAt(mouthPosition)) and (inWater == 0) and (mcontroller.liquidId()== 1) or (mcontroller.liquidId()== 6) then
	    status.addEphemeralEffect("regenerationminor",math.huge)
            status.setPersistentEffects("orcanaprotection", {
              {stat = "foodDelta", baseMultiplier = 0.80},
              {stat = "fallDamageMultiplier", amount = 0.0},
              {stat = "poisonResistance", baseMultiplier = 1.20} 
            })
	    inWater = 1
	else
	  isDry()
        end  
end

function uninit()
  status.removeEphemeralEffect("regenerationminor",math.huge)
  status.clearPersistentEffects("orcanaprotection")
end
