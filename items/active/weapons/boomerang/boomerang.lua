require "/scripts/vec2.lua"
require "/scripts/util.lua"
require "/scripts/activeitem/stances.lua"
require "/scripts/FRHelper.lua"

function init()
    self.critChance = config.getParameter("critChance", 0)
    self.critBonus = config.getParameter("critBonus", 0)
    --*************************************
    -- FU/FR ADDONS

    self.species = world.entitySpecies(activeItem.ownerEntityId())
    if self.species then
        self.helper = FRHelper:new(self.species)
        self.helper:loadWeaponScripts({"boomerang-fire", "boomerang-update", "boomerang-catch"})
    end

    --**************************************
    self.projectileType = config.getParameter("projectileType")
    self.projectileParameters = config.getParameter("projectileParameters")
    self.projectileParameters.power = self.projectileParameters.power * root.evalFunction("weaponDamageLevelMultiplier", config.getParameter("level", 1))
    initStances()

    self.cooldownTime = config.getParameter("cooldownTime", 0)
    self.cooldownTimer = self.cooldownTime

    checkProjectiles()
    if storage.projectileIds then
        setStance("throw")
    else
        setStance("idle")
    end

end



-- *******************************************************
-- FU Crit Damage Script

function setCritDamageBoomerang(damage)
    -- check their equipped weapon
    -- Primary hand, or single-hand equip
    local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
    --used for checking dual-wield setups
    local opposedhandHeldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand() == "primary" and "alt" or "primary")

    local critBonus = (status.stat("critBonus",0) + self.critBonus)/2
    local critChance = self.critChance + config.getParameter("critChanceMultiplier",0) + status.stat("critChanceMultiplier",0) + status.stat("critChance",0)
    local critRoll = math.random(200)

    local crit = critRoll <= critChance
    damage = crit and ((damage*2) + critBonus) or damage

    return damage
end
-- *******************************************************



function update(dt, fireMode, shiftHeld)
    if not self.species then init() end

    self.helper:runScripts("boomerang-update", self, dt, fireMode, shiftHeld)

    updateStance(dt)
    checkProjectiles()

    self.cooldownTimer = math.max(0, self.cooldownTimer - dt)

    if self.stanceName == "idle" and fireMode == "primary" and self.cooldownTimer == 0 then
        self.cooldownTimer = self.cooldownTime
        setStance("windup")
    end

    if self.stanceName == "throw" then
        if not storage.projectileIds then
            setStance("catch")
            self.helper:runScripts("boomerang-catch", self, dt, fireMode, shiftHeld)
        end
    end

    --local species = world.entitySpecies(activeItem.ownerEntityId())

    updateAim()
end

function uninit()
    if self.helper then
        self.helper:clearPersistent()
    end
end

function fire()
    if world.lineTileCollision(mcontroller.position(), firePosition()) then
        setStance("idle")
        return
    end

    local params = copy(self.projectileParameters)
    params.powerMultiplier = activeItem.ownerPowerMultiplier()
    params.ownerAimPosition = activeItem.ownerAimPosition()

    params.power = setCritDamageBoomerang(params.power)

    -- Params enables modifying the boomerang projectile
    self.helper:runScripts("boomerang-fire", self, params)


    if self.aimDirection < 0 then params.processing = "?flipx" end
    local projectileId = world.spawnProjectile(
        self.projectileType,
        firePosition(),
        activeItem.ownerEntityId(),
        aimVector(),
        false,
        params
    )
    if projectileId then
        storage.projectileIds = {projectileId}
    end
    animator.playSound("throw")
end

function checkProjectiles()
    if storage.projectileIds then
        local newProjectileIds = {}
        for i, projectileId in ipairs(storage.projectileIds) do
            if world.entityExists(projectileId) then
                local updatedProjectileIds = world.callScriptedEntity(projectileId, "projectileIds")

                if updatedProjectileIds then
                    for j, updatedProjectileId in ipairs(updatedProjectileIds) do
                        table.insert(newProjectileIds, updatedProjectileId)
                    end
                end
            end
        end
        storage.projectileIds = #newProjectileIds > 0 and newProjectileIds or nil
    end
end
