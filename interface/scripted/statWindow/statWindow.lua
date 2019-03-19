
--- THIS IS THE FRACKIN RACES ONE

function init()
	self.data = root.assetJson("/interface/scripted/statWindow/statWindow.config")
	self.elements = self.data.elements
	self.statuses = self.data.statuses
	self.extraOpen = false
	
	widget.setText("characterName", "^blue;"..world.entityName(player.id()))
	
	local playerRace = player.species()
	local recognized = false
	for _,race in ipairs(self.data.races) do
		if race == playerRace then
			recognized = true
			break
		end
	end
	
	if recognized then
		widget.setImage("characterSuit", "/interface/scripted/techupgrade/suits/"..playerRace.."-"..player.gender()..".png")
		--widget.setText("racialLabel", "Racial traits - "..playerRace) --Moved into populateRacialDescription to get the friendly-text name.
		widget.setVisible("racialDesc", true)
		widget.setVisible("offline", false)
		
		populateRacialDescription(playerRace)
	else
		widget.setText("racialLabel", "ERROR - UNRECOGNIZED SPECIES")
	end
end

function update()
	for _, element in ipairs(self.elements) do
		widget.setText(element.."Resist", math.floor(status.stat(element.."Resistance")*100+0.5).."%")
	end

	widget.clearListItems("immunitiesList.textList")
	for thing,stuff in pairs(self.statuses) do
		local skipping = false

		for _,skipped in ipairs(stuff.skip or {}) do
			if status.stat(skipped) >= 1 then
				skipping = true
				break
			end
		end

		if not skipping then
			if status.stat(thing) >= 1 then
				local listItem = "immunitiesList.textList."..widget.addListItem("immunitiesList.textList")
				widget.setText(listItem..".immunity", stuff.name)
			end
		end
	end
end

function expand()
	player.interact("ScriptPane", "/interface/scripted/statWindow/extraStatsWindow.config", player.id())
end

function populateRacialDescription(race)
	widget.clearListItems("racialDesc.textList")
	
	local JSON = root.assetJson("/species/"..race..".species")
	local charGenLabels = JSON.charGenTextLabels
	local racialName = charGenLabels[#charGenLabels-1] --NOTE: In the species file there is the character generation label list. The second to last is the user-friendly display name of the race.
	widget.setText("racialLabel", "RACIAL TRAITS - " .. racialName:upper()) --It's a standard that this name is all caps but in case someone didn't do that, we'll do it for them.
	
	local str = JSON.charCreationTooltip.description
	local strTbl = {}
	local splitters = {}
	local lists = {}
	local startFound = false
	local skipped = 0
	local skip = false
	local firstskip = false
	local char = ""
	
	--Some text editors use the windows line ending, like notepad++
	--We need to normalize this to just use the unix style ending (\n), as Windows line endings are CRLF (\r\n) and cause double-newlines.
	str = str:gsub("\r\n", "\n")
	
	for i = 1, string.len(str) do
		char = string.sub(str, i, i)
		
		if char == "\n" then
			if firstskip == true then
				skip = true
				if startFound then
					skipped = skipped + 1
					table.insert(splitters, i-skipped)
				else
					startFound = true
				end
			else
				firstskip = true
			end
		end
		
		if startFound then
			if skip then
				skip = false
			else
				table.insert(strTbl, char)
			end
		else
			skipped = skipped + 1
		end
	end
	
	str = ""
	for loc, string in ipairs(strTbl) do
		if loc == #strTbl then
			str = string.gsub(str..string, "- ", "", 1)
			table.insert(lists, str)
		else
			for _,loc2 in ipairs(splitters) do
				if loc == loc2 then
					str = string.gsub(str, "- ", "", 1)
					table.insert(lists, str)
					str = ""
				end
			end
			
			char = string
			str = string.format("%s%s", str, char) -- At this moment, I learned how important string.format truly is. Its all mightyness is able to merge % without breaking!
		end
	end
	
	-- using 'for i' loop because 'i/pairs' tends to fuck up the order
	for i = 1, #lists do
		local listItem = "racialDesc.textList."..widget.addListItem("racialDesc.textList")
		widget.setText(listItem..".trait", lists[i])
	end
end
