function checkHealth()
  self.baseHealth = config.getParameter("baseHealth")
  self.baseEnergy =  config.getParameter("baseEnergy")
  self.healthMultPenalty = self.baseHealth * ( self.baseHealth *  -(1 - (self.foodValue))) 
  self.energyMultBonus = self.baseEnergy * ( self.baseEnergy *  -(1 - (self.foodValue)))  
  self.finalHealth = math.ceil(self.healthMultPenalty * self.baseMod)
  self.finalEnergy = math.ceil(self.healthMultPenalty * self.baseMod)
end

function setValues()
  self.radiationBoost = self.foodValue * 0.5 
  self.powerMultBonus = self.foodValue * 0.15
  self.poisonPenaltyBonusMod = -0.4 + (self.powerMultBonus)
  self.firePenaltyBonusMod = -0.4 + (self.powerMultBonus)
  self.icePenaltyBonusMod = self.foodValue * 0.2
  self.electricPenaltyBonusMod = self.foodValue * 0.1
  self.shadowPenaltyBonusMod = self.foodValue * 0.03
  self.cosmicPenaltyBonusMod = self.foodValue * 0.07
  
  --failsafes so that at 50% food you are hard-locked to a particular amount to not get too weak
  if self.foodValue < 0.5 then  
      self.firePenaltyBonusMod = -0.4
      self.poisonPenaltyBonusMod = -0.34
      self.powerMultBonus = 0 
      self.radiationBoost = 0.25
  end

  status.setPersistentEffects("radienPower", {  
      {stat = "maxHealth", amount = self.finalHealth },
      {stat = "maxEnergy", amount = self.finalEnergy },             
      {stat = "powerMultiplier", baseMultiplier = 1 + self.powerMultBonus},
      {stat = "radioactiveResistance", amount = self.radiationBoost },
      {stat = "poisonResistance", amount = self.poisonPenaltyBonusMod},
      {stat = "fireResistance", amount = self.firePenaltyBonusMod },
      {stat = "iceResistance", amount = self.icePenaltyBonusMod },
      {stat = "electricResistance", amount = self.electricPenaltyBonusMod },
      {stat = "shadowResistance", amount = self.shadowPenaltyBonusMod },
      {stat = "cosmicResistance", amount = self.cosmicPenaltyBonusMod }
  }) 
end



function update(dt)
  self.foodValue = status.resourcePercentage("food")

  if self.foodValue >= 0.98 then
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
