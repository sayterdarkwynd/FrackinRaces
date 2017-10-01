require("/scripts/util.lua")

FRHelper = {}

function FRHelper:new(species)
    local frHelper = {}

    frHelper.species = species
    frHelper.config = root.assetJson("/scripts/raceEffects.config")
    frHelper.speciesConfig = frHelper.config[species] or {}

    frHelper.stats = frHelper.speciesConfig.stats                          -- status modifiers
    frHelper.controlModifiers = frHelper.speciesConfig.controlModifiers    -- control modifiers
    frHelper.controlParameters = frHelper.speciesConfig.controlParameters  -- control parameters
    frHelper.envEffects = frHelper.speciesConfig.envEffects                -- environmental effects
    frHelper.weaponEffects = frHelper.speciesConfig.weaponEffects          -- weapon effects
    frHelper.special = frHelper.speciesConfig.special                      -- status effects applied

    frHelper.scripts = frHelper.speciesConfig.scripts                      -- Scripts
    frHelper.scriptCalls = {}                                              -- Stores the loaded script calls

    frHelper.persistentEffects = {}

    setmetatable(frHelper, extend(self))
    return frHelper
end

-- Applies the given status parameters (name is required for setting persistent effects)
function FRHelper:applyStats(stats, name, params)
    if name then
        status.setPersistentEffects(name, stats.stats or {})
        self.persistentEffects[name] = true
    end
    self:applyControlModifiers(stats.controlModifiers, stats.controlParameters)
    self:loadScripts(stats.scripts)
    self:runScripts(stats.scripts, params)
end

-- Grabs the valid weapon effects and loads any attached scripts
function FRHelper:initWeaponEffects(primaryItem, altItem)
    if not self.weaponEffects then return end
    if not self.currentWeaponEffects then self.currentWeaponEffects = {} end

    for i,weap in ipairs(self.weaponEffects or {}) do
        if weap.combos then -- Weapon combos
            for _,combo in ipairs(weap.combos) do
                if self:validCombo(primaryItem, altItem, combo) then
                    self.currentWeaponEffects[weap.name or "FR_weaponComboEffect"..i] = weap
                    break
                end
            end
        elseif weap.weapons then -- Single weapons
            for _,thing in ipairs(weap.weapons) do
                if (primaryItem and root.itemHasTag(primaryItem, thing)) or (altItem and root.itemHasTag(altItem, thing)) then
                    self.currentWeaponEffects[weap.name or "FR_weaponEffect"..i] = weap
                    break
                end
            end
        end
    end
end

-- Applies the effects gathered in initWeaponEffects
function FRHelper:applyWeaponEffects()
    for name,e in pairs(self.currentWeaponEffects or {}) do
        self:applyStats(e, name)
    end
end

-- Checks if the items match the given combo
function FRHelper:validCombo(item1, item2, combo)
    if #combo == 2 and item1 and item2 then  -- two-weapon combos
        return (root.itemHasTag(item1, combo[1]) and root.itemHasTag(item2, combo[2]))
            or (root.itemHasTag(item1, combo[2]) and root.itemHasTag(item2, combo[1]))
    elseif #combo == 1 and ((item1 and not item2) or (item2 and not item1)) then  -- single-weapon combos
        return root.itemHasTag(item1 or item2, combo[1])
    end
    return false
end

-- Checks for if the given persistent effect is currently applied
function FRHelper:checkStatusApplied(name)
    return #status.getPersistentEffects(name) > 0 and true or false
end

-- Function for clearing applied persistent effects added through applyStats()
-- With name, it clears the effect with the matching name. Otherwise, clears all.
function FRHelper:clearPersistent(name)
    if name then
        status.clearPersistentEffects(name)
        self.persistentEffects[name] = nil
    else
        for thing,_ in pairs(self.persistentEffects) do
            status.clearPersistentEffects(thing)
            self.persistentEffects[thing] = nil
        end
    end
end

-- Applies the set control modifiers/parameters. Missing arguments are replaced with default.
function FRHelper:applyControlModifiers(cM, cP)
    mcontroller.controlModifiers(cM or self.controlModifiers or {})
    mcontroller.controlParameters(cP or self.controlParameters or {})
end

-- Loads all scripts that match the given contexts
function FRHelper:loadScripts(contexts)
    if type(contexts) == "string" then contexts = {contexts} end
    if self.scripts and contexts then
        -- For each script setting
        for _,thing in ipairs(self.scripts) do
            -- Check if it matches any of the contexts
            for _,context in ipairs(contexts) do
                -- If it matches, load the script and add the call and args to the list
                if contains(thing.contexts, context) then
                    self.scriptCalls[context] = self.scriptCalls[context] or {}
                    if self:scriptLoaded(thing.script) then
                        self.scriptCalls[context][thing.script] = { call=self.scriptCalls[thing.script], args=thing.args}
                    else
                        require(thing.script)
                        self.scriptCalls[thing.script] = call
                        _SBLOADED[thing.script] = true
                        self.scriptCalls[context][thing.script] = { call=call, args=thing.args }
                        call = nil
                    end
                end
            end
        end
    end
end

-- Runs all of the loaded scripts of the given context(s)
-- Params is extra things that can be sent (typically parameters from the parent function)
function FRHelper:runScripts(contexts, params)
    params = params or {}
    params.helper = self  -- Fix weird scope issues
    if type(contexts) == "string" then contexts = {contexts} end
    for _,context in ipairs(contexts or {}) do
        if not context or not self.scriptCalls[context] then return end
        for _,thing in pairs(self.scriptCalls[context] or {}) do
            thing.call(thing.args, params)
        end
    end
end

-- Returns whether the given script is loaded
function FRHelper:scriptLoaded(script)
    return _SBLOADED[script] or false
end
