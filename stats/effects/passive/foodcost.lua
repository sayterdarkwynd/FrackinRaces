function init() 

  self.species = world.entitySpecies(entity.id())
  
  if self.species == "avian" then
    self.foodCost = 2
  elseif self.species == "avali" then
    if status.stat("gliding") == 1 then
      self.foodCost = 9
    else
      self.foodCost = 2
    end
  elseif self.species == "saturnian" then
    self.foodCost = 11
  else
    if status.stat("gliding") == 1 then
      self.foodCost = 9
    else
      self.foodCost = 2
    end
  end
  
  effect.addStatModifierGroup({
    {stat = "foodDelta", baseMultiplier = self.foodCost }
  })
end

function update(dt)

end

function uninit()
  
end