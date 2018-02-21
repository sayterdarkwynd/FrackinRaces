function foodCheck()
  if status.isResource("food") then
    self.foodValue = status.resource("food")
  else
    self.foodValue = 40
  end
  self.foodValue = self.foodValue / 100
end

function setHealthTier()
  --3 tiers of hunger, plus the Full state
  self.baseMod = 1
  if self.foodValue <= 0.7 then
    self.baseMod = 1
  elseif self.foodValue <= 0.699 then
    self.baseMod = 50    
  elseif self.foodValue < 0.467 then
    self.baseMod = 55
  elseif self.foodValue < 0.234 then
    self.baseMod = 60
  end
  
  self.baseHealth = 0.95
  self.baseEnergy = 1.1
  self.healthMultPenalty = (self.baseHealth * ( self.baseHealth *  -(1 - (self.foodValue))) )* self.baseMod 
  self.energyMultBonus = (self.baseEnergy * ( self.baseEnergy *  -(1 - (self.foodValue))) )* self.baseMod 

end

function update(dt)
  foodCheck()
  setHealthTier()

sb.logInfo("health = "..self.healthMultPenalty)
sb.logInfo("energy = "..self.energyMultBonus)
  self.radiationBoost = self.foodValue / 1.4 
  self.poisonValueBonus = self.foodValue /2.8 
  self.powerMultBonus = self.foodValue /4.7
  self.firePenaltyBonusMod = -0.4 + (self.powerMultBonus)
  
  --failsafes so that at 50% food you are hard-locked to a particular amount to not get too weak
  if self.foodValue < 0.35 then  
      self.firePenaltyBonusMod = -0.4
      self.poisonValueBonus = 0.185
      self.powerMultBonus = 1.0   
  end
  

        status.setPersistentEffects("radienPower", {  
            {stat = "maxHealth", amount = (self.baseHealth * ( self.baseHealth *  -(1 - (self.foodValue))) )* self.baseMod  },
            {stat = "maxEnergy", amount = (self.baseEnergy * ( self.baseEnergy *  -(1 - (self.foodValue))) )* self.baseMod },             
            {stat = "powerMultiplier", baseMultiplier = 1 + self.powerMultBonus},
            {stat = "radioactiveResistance", amount = self.radiationBoost },
            {stat = "poisonResistance", amount = self.poisonValueBonus},
            {stat = "fireResistance", amount = self.firePenaltyBonusMod }
        })  
  
end

function uninit()
  status.clearPersistentEffects("radienPower")
end
