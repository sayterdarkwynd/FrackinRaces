require "/scripts/status.lua"
function init()
  effect.addStatModifierGroup({
  --{stat = "healthRegen", amount = 2},
  {stat = "poisonStatusImmunity", amount = 1},
  {stat = "slimeImmunity", amount = 1},
  {stat = "slimestickImmunity", amount = 1},
  {stat = "webstickImmunity", amount = 1},
  --{stat = "iceResistance", amount = -1},
  --{stat = "fireResistance", amount = 1},
  --{stat = "electricStatusImmunity", amount = 1},
  --{stat = "fallDamageMultiplier", baseMultiplier = 0}
  })
end