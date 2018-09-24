function init()
  effect.addStatModifierGroup({{stat = "sugarfood", amount = 1}})
  status.clearPersistentEffects("glitchpower1")
  status.clearPersistentEffects("floranpower1")
  status.clearPersistentEffects("veggiepower")  
end

--status.statPositive(`String` statName)
function update(dt)
  if status.stat("isSugar")==1 then
    mcontroller.controlModifiers({
      speedModifier = 1.1,
    })
  end
end

function uninit()
end