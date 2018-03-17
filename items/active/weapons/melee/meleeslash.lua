require "/scripts/FRHelper.lua"

-- Melee primary ability
MeleeSlash = WeaponAbility:new()

function MeleeSlash:init()
	self.damageConfig.baseDamage = self.baseDps * self.fireTime
	self.energyUsage = self.energyUsage or 0
	self.weapon:setStance(self.stances.idle)
	self.cooldownTimer = self:cooldownTime()

	self.weapon.onLeaveAbility = function()
	self.weapon:setStance(self.stances.idle)
	end

    -- **************************
    -- FR values
	self.species = world.entitySpecies(activeItem.ownerEntityId())
	attackSpeedUp = 0 -- base attackSpeed bonus
    -- ************************************************

end

-- Ticks on every update regardless if this is the active ability
function MeleeSlash:update(dt, fireMode, shiftHeld)
	WeaponAbility.update(self, dt, fireMode, shiftHeld)

	self.cooldownTimer = math.max(0, self.cooldownTimer - self.dt)

	if not self.weapon.currentAbility and self.fireMode == (self.activatingFireMode or self.abilitySlot) and self.cooldownTimer == 0 and (self.energyUsage == 0 or not status.resourceLocked("energy")) then
        self:setState(self.windup)
	end

end

-- State: windup
function MeleeSlash:windup()
	self.weapon:setStance(self.stances.windup)

	if self.stances.windup.hold then
        while self.fireMode == (self.activatingFireMode or self.abilitySlot) do
            coroutine.yield()
        end
	else
        util.wait(self.stances.windup.duration)
	end

	if self.energyUsage then
        status.overConsumeResource("energy", self.energyUsage)
	end

	if self.stances.preslash then
        self:setState(self.preslash)
	else
        self:setState(self.fire)
	end
end

-- State: preslash
-- brief frame in between windup and fire
function MeleeSlash:preslash()
	self.weapon:setStance(self.stances.preslash)
	self.weapon:updateAim()

	util.wait(self.stances.preslash.duration)
	self:setState(self.fire)
end



-- ***********************************************************************************************************
-- FR SPECIALS	Functions for projectile spawning
-- ***********************************************************************************************************
function MeleeSlash:firePosition()
	return vec2.add(mcontroller.position(), activeItem.handPosition(self.weapon.muzzleOffset))
end

function MeleeSlash:aimVector()	-- fires straight
	local aimVector = vec2.rotate({1, 0}, self.weapon.aimAngle )
	aimVector[1] = aimVector[1] * mcontroller.facingDirection()
	return aimVector
end

function MeleeSlash:aimVectorRand() -- fires wherever it wants
	local aimVector = vec2.rotate({1, 0}, self.weapon.aimAngle + sb.nrand(inaccuracy, 0))
	aimVector[1] = aimVector[1] * mcontroller.facingDirection()
	return aimVector
end
	-- ***********************************************************************************************************
	-- END FR SPECIALS
	-- ***********************************************************************************************************

-- State: fire
function MeleeSlash:fire()

	self.weapon:setStance(self.stances.fire)
	self.weapon:updateAim()

	-- ******************************************************************************************************************
	-- FR RACIAL BONUSES FOR WEAPONS	--- Bonus effect when attacking
	-- ******************************************************************************************************************
	-- *** ABILITY TYPES
	-- attackSpeedUp = attackSpeedUp+(self.foodValue/120)	-- Attack Speed increase based on food. easily modified
	-- activeItem.setInstanceValue("critChance",math )	-- crit chance:
	-- activeItem.setInstanceValue("critBonus",math )	-- Crit Bonus increase
	-- activeItem.setInstanceValue("elementalType","element" )	-- attack element type
	-- activeItem.setInstanceValue("primaryAbility","ability" )	-- ability
	-- projectileId = world.spawnProjectile("hellfireprojectile",self:firePosition(),activeItem.ownerEntityId(),self:aimVector(),false,params)	-- spawn a projectile

	local species = world.entitySpecies(activeItem.ownerEntityId())
	-- Primary hand, or single-hand equip
	--local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
	--used for checking dual-wield setups
	--local opposedhandHeldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand() == "primary" and "alt" or "primary")
	--local randValue = math.random(100)	-- chance for projectile

    if species then
        if not self.helper then
            self.helper = FRHelper:new(species)
            self.helper:loadWeaponScripts("meleeslash-fire")
        end
        self.helper:runScripts("meleeslash-fire", self)
    end

	-- ***********************************************************************************************************
	-- END FR SPECIALS
	-- ***********************************************************************************************************

	animator.setAnimationState("swoosh", "fire")
	animator.playSound(self.fireSound or "fire")
	animator.burstParticleEmitter((self.elementalType or self.weapon.elementalType) .. "swoosh")

	util.wait(self.stances.fire.duration, function()
	local damageArea = partDamageArea("swoosh")
	self.weapon:setDamage(self.damageConfig, damageArea, self.fireTime)
	end)

	-- ***********************************************************************************************************
	-- END FR SPECIALS
	-- ***********************************************************************************************************
	--vanilla cooldown rate
	self.cooldownTimer = self:cooldownTime()

	-- FR cooldown modifiers
	self.cooldownTimer = math.max(0, self.cooldownTimer * attackSpeedUp )	-- subtract FR bonus from total

end

function MeleeSlash:cooldownTime()
	return self.fireTime - self.stances.windup.duration - self.stances.fire.duration
end

function MeleeSlash:uninit()
	self.weapon:setDamage()
	status.clearPersistentEffects("floranFoodPowerBonus")
	status.clearPersistentEffects("slashbonusdmg")
	self.meleeCountslash = 0
end
