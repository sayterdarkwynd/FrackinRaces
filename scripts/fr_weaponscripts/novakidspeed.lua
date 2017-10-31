function FRHelper:call(args, main, ...)
    local lightLevel = getLight()
    local speedMod = 1.0 - (lightLevel / 200)
    if select(1, ...) and type(select(1, ...)) == "number" then
        main.cooldownTimer = main.cooldownTimer * speedMod
    elseif main.fireType == "burst" then
        main.cooldownTimer = main.cooldownTimer * speedMod
    else
        main.cooldownTimer = main.fireTime * speedMod
    end
end
