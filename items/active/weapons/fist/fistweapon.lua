require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/scripts/status.lua"
require "/items/active/weapons/weapon.lua"

function init()
self.critChance = config.getParameter("critChance", 0)
self.critBonus = config.getParameter("critBonus", 0)
  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, 0)

  self.primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(self.primaryAbility)

  local comboFinisherConfig = config.getParameter("comboFinisher")
  self.comboFinisher = getAbility("comboFinisher", comboFinisherConfig)
  self.weapon:addAbility(self.comboFinisher)

  self.weapon:init()

  self.needsEdgeTrigger = config.getParameter("needsEdgeTrigger", false)
  self.edgeTriggerGrace = config.getParameter("edgeTriggerGrace", 0)
  self.edgeTriggerTimer = 0
  
  self.comboStep = 0
  self.comboSteps = config.getParameter("comboSteps")
  self.comboTiming = config.getParameter("comboTiming")
  self.comboCooldown = config.getParameter("comboCooldown")

  self.weapon.freezeLimit = config.getParameter("freezeLimit", 2)
  self.weapon.freezesLeft = self.weapon.freezeLimit
 
-- *************** FR SPECIAL ********************************
--  "always on" fist weapon bonus
-- ***********************************************************

 	   if self.blockCount == nil then 
 	     self.blockCount = 0
 	   end    	
 	   if self.blockCount2 == nil then 
 	     self.blockCount2 = 0
 	   end  
  	 
 	     local species = world.entitySpecies(activeItem.ownerEntityId())
 	     if species == "munari" then
 	       self.timerCheck = 120
 	     end
             if species == "bunnykin" then
               self.blockCount = self.blockCount + 0.5
               self.blockCount = 1
               status.setPersistentEffects("fistbonusdmg", {
                 {stat = "grit", amount = self.blockCount},
                 {stat = "protection", amount = self.blockCount2}
               }) 
             end      

             if species == "apex" then
               status.setPersistentEffects("fistbonusdmg", {
                 {stat = "critChance", amount = 1}
               }) 
             end               

        -- **********************************************************   
        
        
  updateHand()
end

function update(dt, fireMode, shiftHeld)


-- ***************************************************   
--FR stuff
-- ***************************************************   
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
  local heldItem2 = world.entityHandItem(activeItem.ownerEntityId(), "alt")
  local opposedhandHeldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand() == "primary" and "alt" or "primary")
  local species = world.entitySpecies(activeItem.ownerEntityId())
  local bonusApply = 0
  
-- ***********  Felin movement bonuses ***************
if species == "felin" then  --when using fist weapons, felin are extra swift
  if heldItem then
     if root.itemHasTag(heldItem, "fist") and opposedhandHeldItem and root.itemHasTag(opposedhandHeldItem, "fist") then
       mcontroller.controlModifiers({ speedModifier = 1.15, airJumpModifier = 1.05 })
     end    
  end
  bonusApply = 1
end  
  
  if mcontroller.onGround() then
    self.weapon.freezesLeft = self.weapon.freezeLimit
  end

  if self.comboStep > 0 then
    self.comboTimer = self.comboTimer + dt
    if self.comboTimer > self.comboTiming[2] then
      resetFistCombo()
    end
  end

  self.edgeTriggerTimer = math.max(0, self.edgeTriggerTimer - dt)
  if self.lastFireMode ~= "primary" and fireMode == "primary" then
    self.edgeTriggerTimer = self.edgeTriggerGrace
  end
  self.lastFireMode = fireMode

  if fireMode == "primary" and (not self.needsEdgeTrigger or self.edgeTriggerTimer > 0) then
    if self.comboStep > 0 then  
    
-- *************************************************************************
-- FR "combo based" fist weapon bonus
-- *************************************************************************

             if species == "floran" then
	      status.modifyResource("food", (status.resource("food") * -0.005) )  
             end    
             if species == "munari" then
		     if (self.timerCheck == 0) then
		       status.clearPersistentEffects("munaribonusdmg")
		       status.clearPersistentEffects("boostermunari")		     
		       self.timerCheck = 120
		     else
		       self.blockCount = self.blockCount + 0.01
		       status.setPersistentEffects("munaribonusdmg", { {stat = "powerMultiplier", amount = self.blockCount} })
		       status.addPersistentEffect("boostermunari", "powerboostmunari", math.huge)
		       self.timerCheck = self.timerCheck - dt
		     end
             end     
             
-- **************************************************************************

      if self.comboTimer >= self.comboTiming[1] then        
        if self.comboStep % 2 == 0 then
          if self.primaryAbility:canStartAttack() then
            if self.comboStep == self.comboSteps then
              -- sb.logInfo("[%s] %s fist starting a combo finisher", os.clock(), activeItem.hand())
              self.comboFinisher:startAttack()
            else
              self.primaryAbility:startAttack()
              -- sb.logInfo("[%s] %s fist continued the combo", os.clock(), activeItem.hand())
              advanceFistCombo()
            end
          end
        elseif activeItem.callOtherHandScript("triggerComboAttack", self.comboStep) then
          -- sb.logInfo("[%s] %s fist triggered opposing attack", os.clock(), activeItem.hand())
          advanceFistCombo()
        end
      end   
    else 
      if self.primaryAbility:canStartAttack() then          
        self.primaryAbility:startAttack()      
        if activeItem.callOtherHandScript("resetFistCombo") then
          -- sb.logInfo("[%s] %s fist started a combo", os.clock(), activeItem.hand())
          advanceFistCombo()         
        end
      end
    end
  end

  self.weapon:update(dt, fireMode, shiftHeld) 
  updateHand()
end

function uninit()
  if unloaded then
    activeItem.callOtherHandScript("resetFistCombo")
  end
    self.blockCount = 0
    self.blockCount2 = 0
    status.clearPersistentEffects("floranFoodPowerBonus")
    status.clearPersistentEffects("fistbonusdmg")
    status.clearPersistentEffects("munaribonusdmg")
    status.clearPersistentEffects("boostermunari")    
  self.weapon:uninit()
  
end

-- update which image we're using and keep the weapon visually in front of the hand
function updateHand()
  local isFrontHand = self.weapon:isFrontHand()
  animator.setGlobalTag("hand", isFrontHand and "front" or "back")
  animator.resetTransformationGroup("swoosh")
  animator.scaleTransformationGroup("swoosh", isFrontHand and {1, 1} or {1, -1})
  activeItem.setOutsideOfHand(isFrontHand)
end

-- called remotely to attempt to perform a combo-continuing attack
function triggerComboAttack(comboStep)
  if self.primaryAbility:canStartAttack() then
    -- sb.logInfo("%s fist received combo trigger for combostep %s", activeItem.hand(), comboStep)
    if comboStep == self.comboSteps then    
      self.comboFinisher:startAttack()    
    else
      self.primaryAbility:startAttack()
    end
    return true
  else
    return false
  end
end

-- advance to the next step of the combo
function advanceFistCombo()
  self.comboTimer = 0
  if self.comboStep < self.comboSteps then
    -- sb.logInfo("%s fist advancing combo from step %s to %s", activeItem.hand(), self.comboStep, self.comboStep + 1)
    self.comboStep = self.comboStep + 1
 
  end
end

-- interrupt the combo for various reasons
function resetFistCombo()
  -- sb.logInfo("%s fist resetting combo from step %s to 0", activeItem.hand(), self.comboStep)
  self.comboStep = 0
  self.comboTimer = nil
  return true
end

-- complete the combo, reset and trigger cooldown
function finishFistCombo()
  resetFistCombo()
  self.primaryAbility.cooldownTimer = self.comboCooldown
end
