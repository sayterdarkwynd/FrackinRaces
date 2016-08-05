function init()
  local bounds = mcontroller.boundBox()
  self.critChance = config.getParameter("critChance")
  self.critBonus = config.getParameter("critBonus")
  self.powerModifier = config.getParameter("powerModifier", 0)
  script.setUpdateDelta(10)
end


function generateCrit()

damageOutput = baseDamage + baseDamage * critMult(weapon) + critBonus(weapon)
rawDamage = weapon.damageOutput
damageInput = rawDamage - rawDamage * critMitigation(me)


  if math.random(100) < critChance then
    critDamage = critBonus * powerModifier
  else
    critDamage = 0
  end
  return critDamage
end


function update(dt)
        if status.resourcePositive("perfectBlock") then
          self.healingRate = 1.01 / config.getParameter("healTime", 180)
          status.modifyResourcePercentage("health", self.healingRate * dt)
        end
end


function uninit()

end