function init() 
effect.addStatModifierGroup({
  {stat = "foodDelta", amount = -config.getParameter("foodCost", 4)}
})
end

function update(dt)

end

function uninit()
  
end