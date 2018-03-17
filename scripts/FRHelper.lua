require("/scripts/util.lua")

FRHelper = {}
DynamicScripts = {}

function FRHelper:new(species,gender)
    local frHelper = {}
    frHelper.frconfig = root.assetJson("/frackinraces.config")

    frHelper.species = species
    frHelper.config = root.assetJson("/scripts/raceEffects.config")
    frHelper.speciesConfig = frHelper.config[species] or {}
	
	if frHelper.speciesConfig.gender and frHelper.speciesConfig.gender[gender] then
	  frHelper.speciesConfig = util.mergeTable(frHelper.speciesConfig,frHelper.speciesConfig.gender[gender])
	end
	frHelper.speciesConfig.gender = nil

    frHelper.stats = frHelper.speciesConfig.stats                          -- status modifiers
    frHelper.controlModifiers = frHelper.speciesConfig.controlModifiers    -- control modifiers
    frHelper.controlParameters = frHelper.speciesConfig.controlParameters  -- control parameters
    --frHelper.envEffects = frHelper.speciesConfig.envEffects              -- environmental effects
    --frHelper.weaponEffects = frHelper.speciesConfig.weaponEffects        -- weapon effects
    frHelper.special = frHelper.speciesConfig.special                      -- status effects applied

    --frHelper.scripts = frHelper.speciesConfig.weaponScripts              -- Scripts
    frHelper.scriptCalls = {}                                              -- Stores the loaded script calls

    frHelper.persistentEffects = {}

    setmetatable(frHelper, extend(self))
    return frHelper
end

-- Applies the given status parameters (name is required for setting persistent effects)
-- Extra arguments are sent to any scripts run
function FRHelper:applyStats(stats, name, ...)
    if name then
        status.setPersistentEffects(name, stats.stats or {})
        self.persistentEffects[name] = true
    end
    self:applyControlModifiers(stats.controlModifiers, stats.controlParameters)
    if stats.scripts then
        for _,script in ipairs(stats.scripts) do
            self:runScript(script, ...)
        end
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

-- For weaponabilities
function clearPersistent(name)
    if not self.helper then return end
    self.helper:clearPersistent(name)
end

-- Applies the set control modifiers/parameters. Missing arguments are replaced with default.
function FRHelper:applyControlModifiers(cM, cP)
    mcontroller.controlModifiers(cM or self.controlModifiers or {})
    mcontroller.controlParameters(cP or self.controlParameters or {})
end

-- Load the given script (scripts without context are added to "racialscript" instead)
function FRHelper:loadScript(script)
    local contexts = script.contexts
    local path = script.script
    local args = script.args
    if type(contexts) == "string" then contexts = {contexts} end
    if not contexts then contexts = {"racialscript"} end
    for _,context in ipairs(contexts) do
        self.scriptCalls[context] = self.scriptCalls[context] or {}
        self.scriptCalls[context][args or path] = path
        if not scriptLoaded(script.script) then
            self.call = nil
            require(script.script)
            DynamicScripts[path] = self.call   -- Add to loaded script list
            self.call = nil
        end
    end
end

-- Loads weapon scripts (important)
function FRHelper:loadWeaponScripts(contexts)
    if type(contexts) == "string" then contexts = {contexts} end
    -- For each script setting
    for _,thing in ipairs(self.speciesConfig.weaponScripts or {}) do
        -- Check if it matches any of the contexts
        for _,context in ipairs(contexts or {}) do
            -- If it matches, load the script and add the call and args to the list
            if contains(thing.contexts, context) then
                -- If there's a weapon type restriction, check it
                if thing.weapons then
                    local doLoad = false
                    for _,weap in ipairs(thing.weapons) do
                        if root.itemHasTag(world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand()), weap) then
                            doLoad = true
                            break
                        end
                    end
                    -- If blacklisting, don't load weapons that matched, but load those that didn't
                    if thing.blacklist then doLoad = not doLoad end
                    if doLoad then self:loadScript(thing) end
                else
                    self:loadScript(thing)
                end
            end
        end
    end
end

-- Runs all of the loaded scripts of the given context(s)
-- Params is extra things that can be sent (typically parameters from the parent function)
-- NOTE: For extra parameters, the standard is self, method args, then anything extra!
function FRHelper:runScripts(contexts, ...)
    if type(contexts) == "string" then contexts = {contexts} end
    for _,context in ipairs(contexts or {}) do
        for args,path in pairs(self.scriptCalls[context] or {}) do
            if DynamicScripts[path] then
                self.call = DynamicScripts[path]
                self:call(args, ...)
                self.call = nil
            end
        end
    end
end

-- For running one specific script, loads if necessary.
function FRHelper:runScript(script, ...)
    local path = script.script
    local args = script.args
    if not scriptLoaded(path) then
        self:loadScript(script)
    end
    if DynamicScripts[path] then
        self.call = DynamicScripts[path]
        self:call(args, ...)
        self.call = nil
    end
end

-- Returns whether the given script is loaded
function scriptLoaded(script)
    return _SBLOADED[script] or false
end
