function init() 

  self.species = world.entitySpecies(entity.id())
  
  if self.species == "avian" then
    self.foodCost = 0.095
  elseif self.species == "avali" then
    if status.stat("gliding") == 1 then
      self.foodCost = 1.0
    else
      self.foodCost = 0.2
    end
  elseif self.species == "saturnian" then
    self.foodCost = 2.2
  else  -- comment this last section out when not testing.
    if status.stat("gliding") == 1 then
      self.foodCost = 1.65
    else
      self.foodCost = 0.2
    end
  end
  
  effect.addStatModifierGroup({ {stat = "foodDelta", amount = status.stat("foodDelta")-self.foodCost } })
end

function update(dt)

end

function uninit()
  
end