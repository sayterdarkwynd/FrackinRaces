function foodCheck()
  if status.isResource("food") then
    self.foodValue = status.resource("food")
  else
    self.foodValue = 35
  end
  
  self.foodTier = self.foodValue
  self.foodValue = self.foodValue / 100

end

function setValues()
  self.radiationBoost = self.foodValue / 1.4 
  self.poisonValueBonus = self.foodValue /2.8 
  self.powerMultBonus = self.foodValue /4.7
  self.firePenaltyBonusMod = -0.4 + (self.powerMultBonus)
  --failsafes so that at 50% food you are hard-locked to a particular amount to not get too weak
  if self.foodValue < 0.35 then  
      self.firePenaltyBonusMod = -0.4
      self.poisonValueBonus = 0.185
      self.powerMultBonus = 0 
      self.radiationBoost = 0.25
  end

  status.setPersistentEffects("radienPower", {  
      {stat = "maxHealth", amount = self.healthMultPenalty * self.baseMod },
      {stat = "maxEnergy", amount = self.energyMultBonus * self.baseMod },             
      {stat = "powerMultiplier", baseMultiplier = 1 + self.powerMultBonus},
      {stat = "radioactiveResistance", amount = self.radiationBoost },
      {stat = "poisonResistance", amount = self.poisonValueBonus},
      {stat = "fireResistance", amount = self.firePenaltyBonusMod }
  }) 
end

function checkHealth()
  self.baseHealth = 0.95
  self.baseEnergy = 1.1
  self.healthMultPenalty = self.baseHealth * ( self.baseHealth *  -(1 - (self.foodValue))) 
  self.energyMultBonus = self.baseEnergy * ( self.baseEnergy *  -(1 - (self.foodValue)))  
  self.finalHealth = math.ceil(self.healthMultPenalty * self.baseMod) +0.5
  self.finalEnergy = math.ceil(self.healthMultPenalty * self.baseMod) +0.5
end

function update(dt)
  foodCheck()  -- check if they have food bar or not
  sb.logInfo(" food =  "..self.foodValue)
  if self.foodValue >= 0.69970657348633 then
    self.dt = 1
    self.baseMod = 1
  
  else
    self.dt = 0
    self.baseMod = 1 * (10 + self.dt)  
    self.dt = dt + (self.baseMod)   
  end
  


  
  checkHealth()  -- set health adjustment stats 
  setValues() -- set adjustments to stats

end

function uninit()
  status.clearPersistentEffects("radienPower")
end
