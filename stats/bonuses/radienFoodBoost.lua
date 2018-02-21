function foodCheck()
  if status.isResource("food") then
    self.foodValue = status.resource("food")
  else
    self.foodValue = 30
  end
  self.foodValue = self.foodValue / 100
end

function setHealth()
  self.baseHealth = 0.95
  self.baseEnergy = 1.1
  
  if self.foodValue > 0.35 then  
    self.healthMultPenalty = self.baseHealth * ( self.baseHealth *  -(1 - (self.foodValue))) 
    self.healthMultPenalty = math.floor(self.healthMultPenalty * 10)  
    self.energyMultBonus = self.baseEnergy * ( self.baseEnergy *  -(1 - (self.foodValue)))
    self.energyMultBonus = math.floor(self.energyMultBonus * 10)
  else
    self.healthMultPenalty = -10
    self.energyMultBonus = -11
  end
end

function update(dt)
  foodCheck()
  setHealth()

  self.radiationBoost = self.foodValue / 1.4 
  self.poisonValueBonus = self.foodValue /2.8 
  self.powerMultBonus = self.foodValue /4.6

  --failsafes so that at 50% food you are hard-locked to a particular amount to not get too weak
  if self.foodValue < 0.35 then  
      self.firePenaltyBonusMod = -0.4
      self.poisonValueBonus = 0.185
      self.powerMultBonus = 1.0   
  else
      self.firePenaltyBonusMod = -0.4 + (self.powerMultBonus)
  end
  

        status.setPersistentEffects("radienPower", {  
            {stat = "maxHealth", amount = self.healthMultPenalty  },
            {stat = "maxEnergy", amount = self.energyMultBonus },             
            {stat = "powerMultiplier", baseMultiplier = 1 + self.powerMultBonus},
            {stat = "radioactiveResistance", amount = self.radiationBoost },
            {stat = "poisonResistance", amount = self.poisonValueBonus},
            {stat = "fireResistance", amount = self.firePenaltyBonusMod }
        })  
  
end

function uninit()
  status.clearPersistentEffects("radienPower")
end
