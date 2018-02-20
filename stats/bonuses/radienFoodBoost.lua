function update(dt)
  if status.isResource("food") then
    self.foodValue = status.resource("food")
  else
    self.foodValue = 30
  end


  self.foodValueBase = self.foodValue
  
  self.foodValue = (self.foodValue / 1.4) /100
  self.poisonValueBonus = self.foodValue /2
  self.powerMultBonus = self.foodValue /3.3
  
  if self.foodValueBase < 35 then
    self.firePenaltyBonusMod = -0.4
  else
    self.firePenaltyBonusMod = -0.4 + (self.powerMultBonus)
  end
  
  if self.foodValueBase < 60 then  -- only negatively affect them after a certain percentage is gone
        status.setPersistentEffects("radienPower", {
            {stat = "powerMultiplier", baseMultiplier = 1 + self.powerMultBonus },
            {stat = "radioactiveResistance", amount = self.foodValue },
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
