require("/scripts/vec2.lua")
function init()
  inWater=0
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isCarnivore", amount = 1},
    {stat = "isOmnivore", amount = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    --{stat = "protection", baseMultiplier = config.getParameter("defenseBonus")},
    -- resistances
    {stat = "physicalResistance", amount = config.getParameter("physicalResistance",0)},
    {stat = "electricResistance", amount = config.getParameter("electricResistance",0)},
    {stat = "fireResistance", amount = config.getParameter("fireResistance",0)},
    {stat = "iceResistance", amount = config.getParameter("iceResistance",0)},
    {stat = "poisonResistance", amount = config.getParameter("poisonResistance",0)},
    {stat = "shadowResistance", amount = config.getParameter("shadowResistance",0)},
    {stat = "cosmicResistance", amount = config.getParameter("cosmicResistance",0)},
    {stat = "radioactiveResistance", amount = config.getParameter("radioactiveResistance",0)},
    {stat = "fumudslowImmunity", amount = 1},
    {stat = "wetImmunity", amount = 1},
    {stat = "breathProtection", amount = 1}
    })

  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(5)
  
    if (world.type() == "ocean") or (world.type() == "oceanfloor") or (world.type() == "tidewater") or (world.type() == "tidewaterfloor") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "physicalResistance", baseMultiplier = 1.20},
	      {stat = "maxEnergy", baseMultiplier = 1.10}
	    })
    end    
end

function isDry()
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if not world.liquidAt(mouthPosition) then
	      status.removeEphemeralEffect("regenerationminor",math.huge)
              status.clearPersistentEffects("munariprotection")
	    inWater = 0
	end
end

function update(dt)
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if (world.liquidAt(mouthPosition)) and (inWater == 0) and (mcontroller.liquidId()== 1) or (mcontroller.liquidId()== 58) or (mcontroller.liquidId()== 12) then
	    status.addEphemeralEffect("regenerationminor",math.huge)
            status.setPersistentEffects("munariprotection", {
              {stat = "foodDelta", baseMultiplier = 0.65},
              {stat = "fallDamageMultiplier", amount = 0.0}
            })
	    inWater = 1
	else
	  isDry()
        end  
end

function uninit()
  status.removeEphemeralEffect("regenerationminor",math.huge)
  status.clearPersistentEffects("munariprotection")
  status.clearPersistentEffects("jungleEpic")
end
