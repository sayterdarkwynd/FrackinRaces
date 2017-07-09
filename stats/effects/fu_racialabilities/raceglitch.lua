require("/scripts/vec2.lua")

function init()
  inWater=0
  self.baseMaxHealth = status.stat("maxHealth")
  self.baseMaxEnergy = status.stat("maxEnergy")
  
  effect.addStatModifierGroup({
    -- base Attributes
    {stat = "isRobot", amount = 1},
    {stat = "maxHealth", amount = self.baseMaxHealth * config.getParameter("healthBonus")},
    {stat = "maxEnergy", amount = self.baseMaxEnergy * config.getParameter("energyBonus")},
    --{stat = "powerMultiplier", baseMultiplier = config.getParameter("attackBonus")},
    {stat = "protection", baseMultiplier = config.getParameter("defenseBonus")},
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
    {stat = "shieldBash", amount = 2},
    {stat = "poisonStatusImmunity", amount = 1},
    {stat = "beestingImmunity", amount = 1},
    {stat = "grit", amount = 0.2}
  })
  
  if not status.resource("energy") then -- make sure NPCs arent breaking this
    self.energyValue = 1
  end
  
  script.setUpdateDelta(5)
end

function isDry()
  local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
	if not world.liquidAt(mouthPosition) then
            status.clearPersistentEffects("glitchliquid")
	    inWater = 0
	    deactivateVisualEffects()
	end
end

function update(dt)

  -- does the player have more than 25% energy? if not, we apply a nasty penalty to protections
 self.energyValue = status.resource("energy") / status.stat("maxEnergy")

  if self.energyValue <= 0.25 then
    status.setPersistentEffects("glitchweaken", {
      {stat = "physicalResistance", amount = -0.2},
      {stat = "protection", baseMultiplier = status.stat("protection") * 0.5 }
    })
  else
    status.clearPersistentEffects("glitchweaken")
  end
  
  local mouthPosition = vec2.add(mcontroller.position(), status.statusProperty("mouthPosition"))
  local mouthful = world.liquidAt(mouthposition)
  if (world.liquidAt(mouthPosition)) and (inWater == 0) and (mcontroller.liquidId()== 5) or (mcontroller.liquidId()== 44) or (mcontroller.liquidId()== 11) then
    status.setPersistentEffects("glitchliquid", 
    {
      {stat = "maxEnergy", amount = 1.25 },
      {stat = "energyRegenPercentageRate", amount = 0.484 },
      {stat = "healthRegen", amount = 0.484 }
    })
    inWater = 1    
    activateVisualEffects()	
  else
    isDry()
  end 
end


function deactivateVisualEffects()
  animator.setParticleEmitterActive("sparks", false)	
end

function activateVisualEffects()
  animator.setParticleEmitterOffsetRegion("sparks", mcontroller.boundBox())
  animator.setParticleEmitterActive("sparks", true)	
end

function uninit()
  status.clearPersistentEffects("glitchshield")
  status.clearPersistentEffects("glitchweaken")
  status.clearPersistentEffects("glitchliquid")
end