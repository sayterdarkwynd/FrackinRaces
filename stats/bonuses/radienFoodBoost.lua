
function update(dt)
  if status.isResource("food") then
    self.foodValue = status.resource("food")
  else
    self.foodValue = 30
  end
  
  self.foodValue = self.foodValue / 100
  self.foodValueBase = self.foodValue  -- store value unmodified
  
  self.radiationBoost = self.foodValue / 1.4
  self.poisonValueBonus = self.foodValue /2
  self.powerMultBonus = self.foodValue /3.3
  self.healthMultPenalty = self.foodValue /4
  
  if self.foodValueBase < 35 then  --failsafes
      self.firePenaltyBonusMod = -0.4
      self.foodValue = 0.25
      self.poisonValueBonus = 0.185
      self.powerMultBonus = 1.0   
      self.healthMultPenalty = 0.75
  else
      self.firePenaltyBonusMod = -0.4 + (self.powerMultBonus)
  end
  
  if self.foodValueBase < 65 then  -- only negatively affect them after a certain percentage is gone
        status.setPersistentEffects("radienPower", {
            {stat = "maxHealth", amount = self.healthMultPenalty  },
            {stat = "maxEnergy", amount = self.powerMultBonus },         
            {stat = "powerMultiplier", baseMultiplier = 1 + self.powerMultBonus },
            {stat = "radioactiveResistance", amount = self.radiationBoost },
            {stat = "poisonResistance", amount = self.poisonValueBonus },
            {stat = "fireResistance", amount = self.firePenaltyBonusMod }
        })    
  else
        status.setPersistentEffects("radienPower", {   
            {stat = "powerMultiplier", baseMultiplier = 1.15 },
            {stat = "radioactiveResistance", amount = 0.5 },
            {stat = "poisonResistance", amount = 0.25},
            {stat = "fireResistance", amount = self.firePenaltyBonusMod }
        })  
  end
  
end

function uninit()
  status.clearPersistentEffects("radienPower")
end
