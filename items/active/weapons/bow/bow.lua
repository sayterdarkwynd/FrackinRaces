require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"
require "/scripts/FRHelper.lua"


function init()
    activeItem.setCursor("/cursors/reticle0.cursor")

    self.weapon = Weapon:new()

    self.weapon:addTransformationGroup("weapon", {0,0}, 0)

    local primaryAbility = getPrimaryAbility()
    self.weapon:addAbility(primaryAbility)

    local secondaryAttack = getAltAbility(self.weapon.elementalType)
    if secondaryAttack then
        self.weapon:addAbility(secondaryAttack)
    end

    self.weapon:init()
    --*************************************
    -- FU/FR ADDONS
    self.species = world.entitySpecies(activeItem.ownerEntityId())

    if self.species then
        self.helper = FRHelper:new(self.species)
        self.helper:loadWeaponScripts("bow-update")
    end
    --**************************************
end



function update(dt, fireMode, shiftHeld)
    if not self.species then init() end

    self.helper:clearPersistent()
    self.helper:runScripts("bow-update", self, dt, fireMode, shiftHeld)

    self.weapon:update(dt, fireMode, shiftHeld)
end

function uninit()
    if self.helper then
        self.helper:clearPersistent()
    end
    self.weapon:uninit()
end
