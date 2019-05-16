function init()
	sb.logInfo("------------ INIT THING ------------")
	for thing,_ in pairs(item) do
		--if type(_) == "table" then
			sb.logInfo(thing.." "..tostring(type(_)))
		--end
	end
end

function update(dt, fireMode, shiftHeld)
	sb.logInfo(string.format("%s%s%s", dt, fireMode, shiftHeld))
	--if fireMode ~= "none" then
		--item.
end