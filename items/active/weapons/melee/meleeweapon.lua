require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"
require "/scripts/FRHelper.lua"

function init()
	self.critChance = config.getParameter("critChance", 0)
    self.critBonus = config.getParameter("critBonus", 0)
	animator.setGlobalTag("paletteSwaps", config.getParameter("paletteSwaps", ""))
	animator.setGlobalTag("directives", "")
	animator.setGlobalTag("bladeDirectives", "")

	self.weapon = Weapon:new()

	self.weapon:addTransformationGroup("weapon", {0,0}, util.toRadians(config.getParameter("baseWeaponRotation", 0)))
	self.weapon:addTransformationGroup("swoosh", {0,0}, math.pi/2)

	local primaryAbility = getPrimaryAbility()
	self.weapon:addAbility(primaryAbility)

	local secondaryAttack = getAltAbility()
	if secondaryAttack then
        self.weapon:addAbility(secondaryAttack)
	end



    -- **************************************************
    -- FR EFFECTS
    -- **************************************************

	self.species = world.entitySpecies(activeItem.ownerEntityId())

    if self.species then
        self.helper = FRHelper:new(species)
        self.helper:loadWeaponScripts("weapon-update")
    end

    -- ***************************************************
    -- END FR STUFF
    -- ***************************************************
	self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
    -- ***************************************************
    --FR stuff
    -- ***************************************************
    if not self.species then init() end

    self.helper:runScripts("weapon-update", self, dt, fireMode, shiftHeld)

    -- ***************************************************
    -- END FR STUFF
    -- ***************************************************

	self.weapon:update(dt, fireMode, shiftHeld)
end


function uninit()
    if self.helper then
        self.helper:clearPersistent()
    end
	self.weapon:uninit()
end
