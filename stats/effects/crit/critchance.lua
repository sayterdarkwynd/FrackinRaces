require "/items/active/weapons/weapon.lua"

function init()
  local bounds = mcontroller.boundBox()
  self.critChance = config.getParameter("critChance") or 0.25
  self.critBonus = config.getParameter("critBonus") or 0
  script.setUpdateDelta(10)
end

function setCritDamage(damage)
  local crit = math.random(100) <= self.critChance
  damage = crit and (damage*2) + self.critBonus or damage
  return damage
end



--the function Weapon:damagesource   in weapon.lua   
--it sets damage there... so think just need to apply the setCritDamage in that


--OR use primary status lua




--function Weapon:damageSource(damageConfig, damageArea, damageTimeout)
--  if damageArea then
--    local knockback = damageConfig.knockback
--    if knockback and damageConfig.knockbackDirectional ~= false then
--      knockback = knockbackMomentum(damageConfig.knockback, damageConfig.knockbackMode, self.aimAngle, self.aimDirection)
--    end
--    local damage = damageConfig.baseDamage * self.damageLevelMultiplier * activeItem.ownerPowerMultiplier()
--
--    local damageLine, damagePoly
--    if #damageArea == 2 then
--      damageLine = damageArea
--    else
--      damagePoly = damageArea
--    end
--
--    return {
--      poly = damagePoly,
--      line = damageLine,
--      damage = setCritDamage(damage),
--      trackSourceEntity = damageConfig.trackSourceEntity,
--      sourceEntity = activeItem.ownerEntityId(),
--      team = activeItem.ownerTeam(),
--      damageSourceKind = damageConfig.damageSourceKind,
--      statusEffects = damageConfig.statusEffects,
--      knockback = knockback or 0,
--      rayCheck = true,
--      damageRepeatGroup = damageRepeatGroup(damageConfig.timeoutGroup),
--      damageRepeatTimeout = damageTimeout or damageConfig.timeout
--    }
--  end
--end