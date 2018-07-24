function init()
	attritionFoodDelta=effect.addStatModifierGroup({
		{stat = "foodDelta", baseMultiplier = 0.8},
		{stat = "energyRegenBlockTime", amount = 1.45},
		{stat = "energyRegenPercentageRate", amount = 0.05}
	})
	script.setUpdateDelta(5)
end

function update(dt)

end


function uninit()
	effect.removeStatModifierGroup(attrition)
end