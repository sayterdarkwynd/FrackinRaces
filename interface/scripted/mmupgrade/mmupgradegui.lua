require "/scripts/util.lua"

function init()
  self.currentUpgrades = {}
  self.upgradeConfig = config.getParameter("upgrades")
  self.buttonStateImages = config.getParameter("buttonStateImages")
  self.overlayStateImages = config.getParameter("overlayStateImages")
  self.highlightImages = config.getParameter("highlightImages")
  self.selectionOffset = config.getParameter("selectionOffset")
  self.defaultDescription = config.getParameter("defaultDescription")
  self.autoRefreshRate = config.getParameter("autoRefreshRate")
  self.autoRefreshTimer = self.autoRefreshRate

  self.highlightPulseTimer = 0


	-- *****************
	-- FR STUFF

	-- racial bonuses for MM upgrades in this array
	self.MMstats = {
	    elunite  = { initPower = 1 },
	    apex     = { initRadius = 1 },
	    hylotl   = { initLiquid = 1 },
	    default  = {}
	}
	   
	setmetatable(self.MMstats, {
	  __index = function()
	    return self.MMstats.default
	  end
	})
	
	-- are they a race that gets a MM bonus?

	local species = world.entitySpecies(player.id()) 
	
	
	if self.MMstats[species].initRadius then -- apex get increased Radius
	  self.powerBonus = self.MMstats[species].initRadius
	end
	if self.MMstats[species].initPower then -- elunite get increased mining power
	  self.powerBonus = self.MMstats[species].initPower
	end
	if self.MMstats[species].initLiquid then --hylotl get water collection by default
	  self.powerBonus = self.MMstats[species].initLiquid
          local upgrade = self.upgradeConfig.liquidcollection
          upgrade.setItemParameters.canCollectLiquid = true
          local item = player.essentialItem(upgrade.essentialSlot)
          util.mergeTable(item.parameters, upgrade.setItemParameters)
          item.parameters.upgrades = item.parameters.upgrades or {}
          table.insert(item.parameters.upgrades, "liquidcollection")
          player.giveEssentialItem(upgrade.essentialSlot, item)	 
	end
	self.powerBonus = self.powerBonus or 0
        -- ***************** 

  updateGui()
end

function update(dt)
  self.autoRefreshTimer = math.max(0, self.autoRefreshTimer - dt)
  if self.autoRefreshTimer == 0 then
    updateGui()
    self.autoRefreshTimer = self.autoRefreshRate
  end

  if self.highlightImage then
    self.highlightPulseTimer = self.highlightPulseTimer + dt
    local highlightDirectives = string.format("?multiply=FFFFFF%2x", math.floor((math.cos(self.highlightPulseTimer * 8) * 0.5 + 0.5) * 255))
    widget.setImage("imgHighlight", self.highlightImage .. highlightDirectives)
  end
end

function selectUpgrade(widgetName, widgetData)
  for k, v in pairs(self.upgradeConfig) do
    if v.button == widgetName then
      self.selectedUpgrade = k
      self.highlightPulseTimer = 0
    end
  end
  updateGui()
end


function isOriginalMM()
  local mm = player.essentialItem("beamaxe").name or ""
  if mm == "beamaxe" or 
     mm == "beamaxeapex" or 
     mm == "beamaxeelunite" or 
     mm == "beamaxehylotl" then
     return 1
  else
     return 0
  end
end


function performUpgrade(widgetName, widgetData)
  if selectedUpgradeAvailable() and isOriginalMM()==1 then
    local upgrade = self.upgradeConfig[self.selectedUpgrade]
    if player.consumeItem({name = "manipulatormodule", count = upgrade.moduleCost}) then
      if upgrade.setItem then
        player.giveEssentialItem(upgrade.essentialSlot, upgrade.setItem)
      end

--      if upgrade.setItemParameters then
--        local item = player.essentialItem(upgrade.essentialSlot)
--        
--        util.mergeTable(item.parameters, upgrade.setItemParameters)
--        player.giveEssentialItem(upgrade.essentialSlot, item)
--      end
-- ***************
-- FR STUFF
	if upgrade.setItemParameters then
	  local item = player.essentialItem(upgrade.essentialSlot)
	  
	  -- Racial bonuses here
	  if world.entitySpecies(player.id()) == "apex" and upgrade.setItemParameters.blockRadius then
	    upgrade.setItemParameters.blockRadius = upgrade.setItemParameters.blockRadius + self.powerBonus
	    upgrade.setItemParameters.minBeamWidth = upgrade.setItemParameters.minBeamWidth + self.powerBonus
	    upgrade.setItemParameters.maxBeamWidth = upgrade.setItemParameters.maxBeamWidth + self.powerBonus
	  elseif world.entitySpecies(player.id()) == "elunite" and upgrade.setItemParameters.tileDamage then
	    upgrade.setItemParameters.tileDamage = upgrade.setItemParameters.tileDamage + self.powerBonus
	    upgrade.setItemParameters.minBeamJitter = upgrade.setItemParameters.minBeamJitter + 0.15
	    upgrade.setItemParameters.maxBeamJitter = upgrade.setItemParameters.maxBeamJitter + 0.15   
	  elseif world.entitySpecies(player.id()) == "hylotl" then
	    local upgrade = self.upgradeConfig.liquidcollection
	    upgrade.setItemParameters.canCollectLiquid = true
	  end	  
	  
	  
	  util.mergeTable(item.parameters, upgrade.setItemParameters)
	  player.giveEssentialItem(upgrade.essentialSlot, item)
	end
-- *************
      if upgrade.setStatusProperties then
        for k, v in pairs(upgrade.setStatusProperties) do
          status.setStatusProperty(k, v)
        end
      end

      -- the slot being used
      local mm = player.essentialItem("beamaxe")

-- ***********
-- FR stuff

	if world.entitySpecies(player.id()) == "apex" then
	  mm.parameters.upgrades = mm.parameters.upgrades or {}
	  table.insert(mm.parameters.upgrades, self.selectedUpgrade)
	  mm.name = "beamaxeapex"
	  player.giveEssentialItem("beamaxe", mm)          
	elseif world.entitySpecies(player.id()) == "elunite" then
	  mm.parameters.upgrades = mm.parameters.upgrades or {}
	  table.insert(mm.parameters.upgrades, self.selectedUpgrade)
	  mm.name = "beamaxeelunite"
	  player.giveEssentialItem("beamaxe", mm)  
	elseif world.entitySpecies(player.id()) == "hylotl" then
	  mm.parameters.upgrades = mm.parameters.upgrades or {}
	  table.insert(mm.parameters.upgrades, self.selectedUpgrade)
	  mm.name = "beamaxehylotl"
	  player.giveEssentialItem("beamaxe", mm) 	  
	else
	  mm.parameters.upgrades = mm.parameters.upgrades or {}
	  table.insert(mm.parameters.upgrades, self.selectedUpgrade)
	  player.giveEssentialItem("beamaxe", mm)          
	end 
-- ****************	


      updateGui()
    end
  end
end

function updateGui()
  updateCurrentUpgrades()

  for k, v in pairs(self.upgradeConfig) do
    if self.currentUpgrades[k] then
      widget.setButtonImages(v.button, self.buttonStateImages.complete)
      widget.setButtonOverlayImage(v.button, self.overlayStateImages.complete)
    elseif hasPrereqs(v.prerequisites) then
      widget.setButtonImages(v.button, self.buttonStateImages.available)
      widget.setButtonOverlayImage(v.button, v.icon)
    else
      widget.setButtonImages(v.button, self.buttonStateImages.locked)
      widget.setButtonOverlayImage(v.button, self.overlayStateImages.locked)
    end
  end

  local playerModuleCount = player.hasCountOfItem("manipulatormodule")
  if self.selectedUpgrade then
    local upgrade = self.upgradeConfig[self.selectedUpgrade]
    widget.setVisible("imgSelection", true)
    local buttonPosition = widget.getPosition(upgrade.button)
    widget.setPosition("imgSelection", {buttonPosition[1] + self.selectionOffset[1], buttonPosition[2] + self.selectionOffset[2]})
    widget.setVisible("imgHighlight", true)
    self.highlightImage = self.highlightImages[upgrade.highlight] or ""
    widget.setText("lblUpgradeDescription", upgrade.description)
    widget.setText("lblModuleCount", string.format("%s / %s", playerModuleCount, upgrade.moduleCost))
    widget.setButtonEnabled("btnUpgrade", selectedUpgradeAvailable())
  else
    widget.setVisible("imgSelection", false)
    widget.setVisible("imgHighlight", false)
    self.highlightImage = nil
    widget.setText("lblUpgradeDescription", self.defaultDescription)
    widget.setText("lblModuleCount", string.format("%s / --", playerModuleCount))
    widget.setButtonEnabled("btnUpgrade", false)
  end
end

function updateCurrentUpgrades()
  self.currentUpgrades = {}

  local mm = player.essentialItem("beamaxe") or {}
  local currentUpgrades = mm.parameters.upgrades or {}
  if isOriginalMM()==1 then
	  for i, v in ipairs(currentUpgrades) do
	    self.currentUpgrades[v] = true
	  end
  end
end

function hasPrereqs(prereqs)
  if isOriginalMM()==1 then
	  for i, v in ipairs(prereqs) do
	    if not self.currentUpgrades[v] then
	      return false
	    end
	  end

	  return true
  end
end

function selectedUpgradeAvailable()
  if isOriginalMM()==1 then
  return self.selectedUpgrade
     and not self.currentUpgrades[self.selectedUpgrade]
     and hasPrereqs(self.upgradeConfig[self.selectedUpgrade].prerequisites)
     and (player.hasCountOfItem("manipulatormodule") >= self.upgradeConfig[self.selectedUpgrade].moduleCost)
  end
end

function addItemParameters(slot, parameters)
  if isOriginalMM()==1 then
  local item = player.essentialItem(slot)
  util.mergeTable(item.parameters, parameters)
  player.giveEssentialItem(slot, item)
  end
end

function resetTools()
  player.giveEssentialItem("beamaxe", "beamaxe")
  player.removeEssentialItem("wiretool")
  player.removeEssentialItem("painttool")
  status.setStatusProperty("bonusBeamGunRadius", 0)
  updateGui()
end
