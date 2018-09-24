function FRHelper:call(args, main, ...)
    local heldItem = world.entityHandItem(activeItem.ownerEntityId(), "primary")
    local altItem = world.entityHandItem(activeItem.ownerEntityId(), "alt")
    if self:validCombo(heldItem, altItem, { "wand", "dagger" }) then
        local energyValue = status.resource("energy") or 50
        local randValue = math.random(100)
        if (randValue <= 40) and energyValue >= 50 then	-- spawn a projectile if rand is good and they have enough energy
            params = { power = energyValue/24, damageKind = "fire", timeToLive = 0.3, speed = 30, projectileCount = 1, piercing = false }
            params2 = { power = energyValue/20, damageKind = "ice", timeToLive = 0.4, speed = 45, projectileCount = 1, piercing = false }
            params3 = { power = energyValue/16, damageKind = "poison", timeToLive = 0.5, speed = 60, projectileCount = 1, piercing = true }
            local function spawnProjectile(energy, params)
                if status.resource("energy") then status.modifyResource("energy", energyValue * energy) end
                world.spawnProjectile("energycrystal",main:firePosition(),activeItem.ownerEntityId(),main:aimVector(),false,params)
                animator.playSound("avian")
            end
            local randPower = math.random(5)
            if randPower <= 3 then
                spawnProjectile(-0.2, params)
            elseif randPower == 4 then
                spawnProjectile(-0.5, params2)
            elseif randPower == 5 then
                spawnProjectile(-0.7, params3)
            end
        end
    end
end
