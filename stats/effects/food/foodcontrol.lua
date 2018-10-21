function init()
  feedType()
  if status.stat("isCarnivore") then
    -- load carnivore effect
  elseif status.stat("isHerbivore") then
    -- load herbivore effect
  elseif status.stat("isOmnivore") then
    -- load omnivore effect
  elseif status.stat("isRobot") then
    -- load robot effect
  elseif status.stat("isSugar") then
    -- load sugar effect
  elseif status.stat("isRadien") then
    -- load sugar effect    
  end

  --script.setUpdateDelta(5)
end

function update(dt)

end

function uninit()

end
