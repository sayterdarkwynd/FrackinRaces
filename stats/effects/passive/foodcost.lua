function init() 

  self.species = world.entitySpecies(entity.id())
  
  if self.species == "avian" then
    self.foodCost = 0.1
  elseif self.species == "avali" then
    if status.stat("gliding") == 1 then
      self.foodCost = 1.0
    else
      self.foodCost = 0.15
    end
  elseif self.species == "saturnian" then
    self.foodCost = 1.5
  else  -- comment this last section out when not testing.
      self.foodCost = 2
  end
  
  effect.addStatModifierGroup({
    {stat = "foodDelta", amount = -self.foodCost }
  })
end

function update(dt)

end

function uninit()
  
end