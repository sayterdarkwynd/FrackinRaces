function init()
  effect.addStatModifierGroup({{stat = "foodDelta", baseMultiplier = 0.8}})
  effect.addStatModifierGroup({{stat = "energyRegenBlockTime", amount = 1.45}})
  effect.addStatModifierGroup({{stat = "energyRegenPercentageRate", amount = 0.05}})
  script.setUpdateDelta(5)
end

function update(dt)

end


function uninit()
  
end