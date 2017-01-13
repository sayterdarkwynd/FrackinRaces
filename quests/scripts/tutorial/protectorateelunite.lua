require("/quests/scripts/portraits.lua")
require("/quests/scripts/questutil.lua")

function init()
end

function questStart()
 
end

function questComplete()
  player.giveEssentialItem("beamaxe", "beamaxeelunite")
end

function update(dt)
	if player.hasItem("brokenprotectoratebroadsword") then
          quest.complete()
	end
end

function uninit()
end
