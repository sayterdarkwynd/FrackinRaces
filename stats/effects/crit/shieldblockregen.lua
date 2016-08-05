function init()
  local bounds = mcontroller.boundBox()
  script.setUpdateDelta(10)
end

-- not working right. heals every time i press block. need to only be on a perfect block
function update(dt)
        if status.resourcePositive("perfectBlock") then
          self.healingRate = 24.01 / 2
          status.modifyResourcePercentage("health", self.healingRate * dt)
        end
end


function uninit()

end