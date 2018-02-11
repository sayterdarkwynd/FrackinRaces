function FRHelper:call(args, main, ...)
    local lightLevel = getLight()
    local speedMod = (args.minSpeed or 1) - (lightLevel / (args.lightValue or 200))
    if select(1, ...) and type(select(1, ...)) == "number" then
        main.cooldownTimer = main.cooldownTimer * speedMod
        self:applyStats({ stats={ {stat="powerMultiplier", multiplier=1 - (1 - speedMod) * 0.5} } }, "FR_novakidSpeedPenalty")
    elseif main.fireType == "burst" then
        main.cooldownTimer = main.cooldownTimer * speedMod
        self:applyStats({ stats={ {stat="powerMultiplier", multiplier=1 - (1 - speedMod) * 0.5} } }, "FR_novakidSpeedPenalty")
    else
        main.cooldownTimer = main.fireTime * speedMod
    end
end
