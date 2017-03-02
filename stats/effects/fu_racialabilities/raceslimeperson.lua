require("/scripts/vec2.lua")

function init()
  inWater=0
  self.gritBoost = config.getParameter("gritBonus",0)
  self.shieldBoost = config.getParameter("shieldBoost",0)
  baseValue = config.getParameter("healthBonus",0)*(status.resourceMax("health"))
  baseValue2 = config.getParameter("energyBonus",0)*(status.resourceMax("energy"))
  
  effect.addStatModifierGroup({
    {stat = "poisonStatusImmunity", amount = 1 },
    {stat = "slimeImmunity", amount = 1 },
    {stat = "slimestickImmunity", amount = 1 },
    {stat = "webstickImmunity", amount = 1 },
    {stat = "fallDamageMultiplier", amount = 0.85},
    {stat = "maxHealth", amount = baseValue },
    {stat = "maxEnergy", amount = baseValue2 },
    {stat = "grit", amount = self.gritBoost },
    {stat = "shieldRegen", baseMultiplier = self.shieldBoost },
    {stat = "physicalResistance", amount = 0.25},
    {stat = "fireResistance", amount = 0},
    {stat = "iceResistance", amount = 0},
    {stat = "electricResistance", amount = 0},
    {stat = "poisonResistance", amount = 0},
    {stat = "shadowResistance", amount = 0}
  })

  self.movementParams = mcontroller.baseParameters()  
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
  
end


function isDry()

local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
status.setPersistentEffects("glitchpower", {{stat = "physicalResistance", amount = 0.25}})
	if not world.liquidAt(mouthPosition) then
            status.clearPersistentEffects("glitchweaken")
            status.clearPersistentEffects("glitchweaken2")
            status.clearPersistentEffects("glitchweaken3")
	    inWater = 0
	end
end

function update(dt)

local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
local mouthful = world.liquidAt(mouthposition)


	if world.liquidAt(mouthPosition) and inWater == 0 then
	    status.clearPersistentEffects("glitchpower")
            status.setPersistentEffects("glitchweaken", {{stat = "physicalResistance", amount = -0.5}})
            status.setPersistentEffects("glitchweaken2", {{stat = "maxHealth", amount = -20}})
            status.setPersistentEffects("glitchweaken3", {{stat = "maxEnergy", amount = -30}})
	    inWater = 1
	else
	  isDry()
        end 			
end

function uninit()
              status.clearPersistentEffects("glitchpower")
              status.clearPersistentEffects("glitchweaken")
              status.clearPersistentEffects("glitchweaken2")
              status.clearPersistentEffects("glitchweaken3")  
end