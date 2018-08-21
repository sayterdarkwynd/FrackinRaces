function init() 

  self.species = world.entitySpecies(entity.id())
  
  if self.species == "avian" then
    self.foodCost = 3
  elseif self.species == "avali" then
    self.foodCost = 3
  elseif self.species == "saturnian" then
    self.foodCost = 4
  else
    self.foodCost = 4
  end
  
  effect.addStatModifierGroup({
    {stat = "foodDelta", amount = -self.foodCost }
  })
end

function update(dt)

end

function uninit()
  
end