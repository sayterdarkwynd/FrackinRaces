require "/items/active/weapons/melee/meleeslash.lua"

-- Spear stab attack
-- Extends normal melee attack and adds a hold state
SpearStab = MeleeSlash:new()

function SpearStab:init()
  MeleeSlash.init(self)

  self.holdDamageConfig = sb.jsonMerge(self.damageConfig, self.holdDamageConfig)
  self.holdDamageConfig.baseDamage = self.holdDamageMultiplier * self.damageConfig.baseDamage
end

function SpearStab:fire()
  MeleeSlash.fire(self)
  if self.fireMode == "primary" and self.allowHold ~= false then
    self:setState(self.hold)
--*************************************    
-- FU/FR ADDONS
 if self.blockCount == nil then 
   self.blockCount = 5 
 end
 if self.blockCount2 == nil then 
   self.blockCount2 = 0
 end
 if self.blockCount3 == nil then 
   self.blockCount3 = 0
 end 
          if world.entitySpecies(activeItem.ownerEntityId()) == "floran" then      
            self.blockCount = self.blockCount + 2
            status.setPersistentEffects("spearbonus", {{stat = "protection", amount = self.blockCount}})  
          end   
          if world.entitySpecies(activeItem.ownerEntityId()) == "sergal" then      
            self.blockCount = self.blockCount + 5
            status.setPersistentEffects("spearbonus", {
              { stat = "protection", amount = self.blockCount },
              { stat = "maxHealth", baseMultiplier = 1.15 }
            }) 
            local bounds = mcontroller.boundBox()    
          end  
          if world.entitySpecies(activeItem.ownerEntityId()) == "orcana" then      
            self.blockCount2 = self.blockCount2 + 0.25
            status.setPersistentEffects("spearbonus", {{stat = "powerMultiplier", amount = self.blockCount2}})  
          end   
          if world.entitySpecies(activeItem.ownerEntityId()) == "argonian" then      
            self.blockCount3 = self.blockCount3 + 0.15
            status.setPersistentEffects("spearbonus", {{stat = "powerMultiplier", amount = self.blockCount3}})  
          end         
--************************************** 
  end
end

function SpearStab:hold()
  self.weapon:setStance(self.stances.hold)
  self.weapon:updateAim()
  while self.fireMode == "primary" do
    local damageArea = partDamageArea("blade")
    self.weapon:setDamage(self.holdDamageConfig, damageArea)     
    coroutine.yield()
  end

  self.cooldownTimer = self:cooldownTime()
end


function SpearStab:uninit()
  status.clearPersistentEffects("spearbonus")
  self.blockCount = 0
end