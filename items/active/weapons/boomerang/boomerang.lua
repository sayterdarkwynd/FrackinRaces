require "/scripts/vec2.lua"
require "/scripts/util.lua"
require "/scripts/activeitem/stances.lua"

function init()
  --*************************************    
  -- FU/FR ADDONS
   if self.blockCount == nil then 
     self.blockCount = 0 
     self.blockCount2 = 0
   end

local species = world.entitySpecies(activeItem.ownerEntityId())
   


if species == "fenerox" then  
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
  if heldItem then
     if root.itemHasTag(heldItem, "boomerang") then 
	  self.blockCount = self.blockCount + 0.10
	  self.blockCount2 = 1
	  status.setPersistentEffects("bonusdmg", {
	    {stat = "powerMultiplier", amount = self.blockCount},
	    {stat = "protection", amount = self.blockCount2 }
	    })  	
	    local bounds = mcontroller.boundBox()
     end
  end
  heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
  if heldItem then
     if root.itemHasTag(heldItem, "boomerang") then 
	  self.blockCount = self.blockCount + 0.10
	  self.blockCount2 = 1
	  status.setPersistentEffects("bonusdmg", {
	    {stat = "powerMultiplier", amount = self.blockCount},
	    {stat = "protection", amount = self.blockCount2 }
	    })  	
	    local bounds = mcontroller.boundBox()
     end  
   end
end


if species == "lamia" then  
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
  if heldItem then
     if root.itemHasTag(heldItem, "chakram") then 
	  self.blockCount = self.blockCount + 1.10
	  self.blockCount2 = self.blockCount2 + 1.10
	  self.blockCount3 = self.blockCount3 + 1.10
	  status.setPersistentEffects("bonusdmg", {
	    {stat = "powerMultiplier", baseMultiplier = self.blockCount},
	    {stat = "maxHealth", baseMultiplier = self.blockCount2 },
	    {stat = "grit", baseMultiplier = self.blockCount3 }
	    })  	
	    local bounds = mcontroller.boundBox()
     end
  end
  heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
  if heldItem then
     if root.itemHasTag(heldItem, "chakram") then 
	  self.blockCount = self.blockCount + 1.10
	  self.blockCount2 = self.blockCount2 + 1.10
	  self.blockCount3 = self.blockCount3 + 1.10
	  status.setPersistentEffects("bonusdmg2", {
	    {stat = "powerMultiplier", baseMultiplier = self.blockCount},
	    {stat = "maxHealth", baseMultiplier = self.blockCount2 },
	    {stat = "grit", baseMultiplier = self.blockCount3 }
	    })  	
	    local bounds = mcontroller.boundBox()
     end  
   end
end


if species == "bunnykin" then  
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
  if heldItem then
     if root.itemHasTag(heldItem, "boomerang") or root.itemHasTag(heldItem, "chakram") then  
	  self.blockCount = self.blockCount + 0.15
	  status.setPersistentEffects("bonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
     end
  end
  heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
  if heldItem then
     if root.itemHasTag(heldItem, "boomerang") or root.itemHasTag(heldItem, "chakram") then 
	  self.blockCount = self.blockCount + 0.15
	  status.setPersistentEffects("bonusdmg", {{stat = "powerMultiplier", amount = self.blockCount}})  
     end  
   end
end

if species == "elunite" then  
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
  if heldItem then
     if root.itemHasTag(heldItem, "boomerang") or root.itemHasTag(heldItem, "chakram") then  
	  self.blockCount = self.blockCount + 0.125
	  status.setPersistentEffects("bonusdmg", {
	    {stat = "powerMultiplier", amount = self.blockCount},
	    {stat = "protection", amount = 2}
	  }) 
     end
  end
  heldItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
  if heldItem then
     if root.itemHasTag(heldItem, "boomerang") or root.itemHasTag(heldItem, "chakram") then 
	  self.blockCount = self.blockCount + 0.125
	  status.setPersistentEffects("bonusdmg", {
	    {stat = "powerMultiplier", amount = self.blockCount},
	    {stat = "protection", amount = 2}
	  }) 
     end  
   end
end
           
--************************************** 
  self.projectileType = config.getParameter("projectileType")
  self.projectileParameters = config.getParameter("projectileParameters")
  self.projectileParameters.power = self.projectileParameters.power * root.evalFunction("weaponDamageLevelMultiplier", config.getParameter("level", 1))
  initStances()

  self.cooldownTime = config.getParameter("cooldownTime", 0)
  self.cooldownTimer = self.cooldownTime

  checkProjectiles()
  if storage.projectileIds then
    setStance("throw")
  else
    setStance("idle")
  end

end



function setCritDamageBoomerang(damage)
  -- *******************************************************
  -- FU Crit Damage Script
  -- *******************************************************
  -- FU Crit Damage Script
  self.critChance = ( config.getParameter("critChance",0) + (config.getParameter("level",0)/2) ) or 1
  self.critBonus = ( ( ( (config.getParameter("critBonus",0)   + (config.getParameter("level",0)/2) )  * self.critChance ) /100 ) /2 ) or 0  
  -- *******************************************************
  

  self.critChance = (self.critChance  + config.getParameter("critChanceMultiplier",0)) 
  local crit = math.random(100) <= self.critChance
  local critDamage = crit and (damage*2) + self.critBonus or damage
  if crit then status.addEphemeralEffect("crithit", 0.5, activeItem.ownerEntityId()) end  
  return critDamage  
end



function update(dt, fireMode, shiftHeld)
  updateStance(dt)
  checkProjectiles()

  self.cooldownTimer = math.max(0, self.cooldownTimer - dt)

  if self.stanceName == "idle" and fireMode == "primary" and self.cooldownTimer == 0 then
    self.cooldownTimer = self.cooldownTime
    setStance("windup")
  end

  if self.stanceName == "throw" then
    if not storage.projectileIds then
      setStance("catch")
    end
  end
  
    local species = world.entitySpecies(activeItem.ownerEntityId())
    if species == "fenerox" then      -- fenerox move faster when wielding boomerangs
	mcontroller.controlModifiers({ speedModifier = 1.15 })              
    end 
            
  updateAim()
end

function uninit()
  status.clearPersistentEffects("bonusdmg")
  status.clearPersistentEffects("bonusdmg2")
  self.blockCount = 0
end

function fire()
  if world.lineTileCollision(mcontroller.position(), firePosition()) then
    setStance("idle")
    return
  end

  local params = copy(self.projectileParameters)
  params.powerMultiplier = activeItem.ownerPowerMultiplier()
  params.ownerAimPosition = activeItem.ownerAimPosition()
  
  params.power = setCritDamageBoomerang(params.power)
  
        local species = world.entitySpecies(activeItem.ownerEntityId())
	if species == "floran" then  --florans use food when attacking
	    status.modifyResource("food", (status.resource("food") * -0.005) )
	end
	
	
  if self.aimDirection < 0 then params.processing = "?flipx" end
  local projectileId = world.spawnProjectile(
      self.projectileType,
      firePosition(),
      activeItem.ownerEntityId(),
      aimVector(),
      false,
      params
    )
  if projectileId then
    storage.projectileIds = {projectileId}
  end
  animator.playSound("throw")
end

function checkProjectiles()
  if storage.projectileIds then
    local newProjectileIds = {}
    for i, projectileId in ipairs(storage.projectileIds) do
      if world.entityExists(projectileId) then
        local updatedProjectileIds = world.callScriptedEntity(projectileId, "boomerangProjectileIds")

        if updatedProjectileIds then
          for j, updatedProjectileId in ipairs(updatedProjectileIds) do
            table.insert(newProjectileIds, updatedProjectileId)
          end
        end
      end
    end
    storage.projectileIds = #newProjectileIds > 0 and newProjectileIds or nil
  end
end