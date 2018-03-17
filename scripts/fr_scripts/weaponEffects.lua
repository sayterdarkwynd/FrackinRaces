--[[
This is intended to be run from raceability.lua through a mapping in frackinraces.config
Structure:

"weaponEffects" : [
    {
        "name" : "bob"    -- Specify a name for the persistent effect. Useful for scripting or complex interactions.
        "weapons" : [ "dagger", "broadsword", ... ],            -- single weapons
        -- OR --
        "combos" : [ [ "dagger", "dagger" ], [ "boomerang" ] ]  -- weapon combos (single-weapon combos are holding only 1 weapon)

        "stats" : [],              -- Stats
        "controlModifiers" : [],   -- Control modifiers
        "controlParameters" : [],  -- Control parameters
        "scripts" : []             -- Can be used to call other scripts.
    },
    {
        ...
    }
]
]]

function FRHelper:call(args)
    local primaryItem = world.entityHandItem(entity.id(), "primary")
    local altItem = world.entityHandItem(entity.id(), "alt")
    for i,weap in ipairs(args or {}) do
        if weap.combos then -- Weapon combos
            for _,combo in ipairs(weap.combos) do
                if self:validCombo(primaryItem, altItem, combo) then
                    self:applyStats(weap, weap.name or "FR_weaponComboEffect"..i)
                    break
                end
            end
        elseif weap.weapons then -- Single weapons
            for _,thing in ipairs(weap.weapons) do
                if (primaryItem and root.itemHasTag(primaryItem, thing)) or (altItem and root.itemHasTag(altItem, thing)) then
                    self:applyStats(weap, weap.name or "FR_weaponEffect"..i)
                    break
                end
            end
        end
    end
end
