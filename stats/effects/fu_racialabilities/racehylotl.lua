require("/scripts/vec2.lua")
function init()
  inWater=0
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  if not status.stat("maxBreath") then
    self.baseBreath = 1
  else
    self.baseBreath = status.stat("maxBreath")
  end
  
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isOmnivore", amount = 1},
    {stat = "maxBreath", amount = 1500},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    --{stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    {stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    --{stat = "protection", baseMultiplier = config.getParameter("defenseBonus")},
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
    {stat = "poisonStatusImmunity", amount = 1},
    {stat = "beestingImmunity", amount = 1},
    {stat = "grit", amount = 0.2}
  })

  script.setUpdateDelta(5)

    if (world.type() == "ocean") or (world.type() == "oceanfloor") then
	    status.setPersistentEffects("jungleEpic", {
	      {stat = "protection", baseMultiplier = 1.15},
	      {stat = "maxHealth", baseMultiplier = 1.12},
	      {stat = "maxEnergy", baseMultiplier = 1.12}
	    })
    end    
end

function isDry()
local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if not world.liquidAt(mouthPosition) then
            status.clearPersistentEffects("hylotlprotection")
	    inWater = 0
	end
end

function update(dt)
	if mcontroller.zeroG() and self.baseBreath > 1 then  -- disable extra breath in space
	    status.setPersistentEffects("hylotlprotection", {
		{stat = "maxBreath", baseMultiplier = 1}
	    })
	end

local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
local mouthful = world.liquidAt(mouthposition)
	if (world.liquidAt(mouthPosition)) and (inWater == 0) and (mcontroller.liquidId()== 1) or (mcontroller.liquidId()== 6) or (mcontroller.liquidId()== 58) or (mcontroller.liquidId()== 12) then
            status.setPersistentEffects("hylotlprotection", {
              {stat = "physicalResistance", baseMultiplier = 1.20},
              {stat = "perfectBlockLimit", amount = 2},
              {stat = "maxHealth", baseMultiplier = 1.25}
            })
	    inWater = 1
	else
	  isDry()
        end 
end

function uninit()
  status.clearPersistentEffects("hylotlprotection")
  status.clearPersistentEffects("jungleEpic")
end