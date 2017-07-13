require("/scripts/vec2.lua")
function init()
  inWater=0
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")

    effect.addStatModifierGroup({
	    -- base Attributes
	    {stat = "isCarnivore", amount = 1},
	    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
	    --{stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
	    {stat = "protection", baseMultiplier = 1.1},
	    -- resistances
	    {stat = "physicalResistance", amount = config.getParameter("physicalResistance")},
	    {stat = "electricResistance", amount = config.getParameter("electricResistance")},
	    {stat = "fireResistance", amount = config.getParameter("fireResistance")},
	    {stat = "iceResistance", amount = config.getParameter("iceResistance")},
	    {stat = "poisonResistance", amount = config.getParameter("poisonResistance")},
	    {stat = "shadowResistance", amount = config.getParameter("shadowResistance")},
	    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance")},
	    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance")},
	    --other
	    {stat = "maxBreath", amount = 2000},
	    {stat = "breathRegenerationRate", amount = 70},
	    {stat = "wetImmunity", amount = 1}
    })  

	
    if (world.type() == "ocean") or (world.type() == "oceanfloor") or (world.type() == "tidewater") or (world.type() == "tidewaterfloor") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "maxHealth", baseMultiplier = 1.20},
	      {stat = "maxEnergy", baseMultiplier = 1.20}
	    })
    end    
    script.setUpdateDelta(5)
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
              {stat = "foodDelta", baseMultiplier = 0.50},
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
