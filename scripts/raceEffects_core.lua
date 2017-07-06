require("/scripts/vec2.lua")
local fuold2Init = init
local fuold2Update = update
local fuold2Uninit = uninit

function init()
  fuoldInit()
  self.lastYPosition = 0
  self.lastYVelocity = 0
  self.fallDistance = 0
  local bounds = mcontroller.boundBox() --Mcontroller for movement
  
  self.raceParams = {}
end



-- find their race
function getRace()
  self.race = world.entitySpecies(entity.id()
end

function setRacialStats()
  --core attributes
    self.raceParams.healthBonus = config.getParameter()
    self.raceParams.energyBonus = config.getParameter()
    self.raceParams.attackBonus = config.getParameter()
    self.raceParams.defenseBonus = config.getParameter()
  --resistances
    self.raceParams.physicalResistance = config.getParameter()
    self.raceParams.electricResistance = config.getParameter()
    self.raceParams.fireResistance = config.getParameter()
    self.raceParams.iceResistance = config.getParameter()
    self.raceParams.poisonResistance = config.getParameter()
    self.raceParams.shadowResistance = config.getParameter()
    self.raceParams.cosmicResistance = config.getParameter()
    self.raceParams.radioactiveResistance = config.getParameter()
  -- speed, jump, mobility, knockback etc
    self.raceParams.knockbackResistance = config.getParameter()
    self.raceParams.speedBonus = config.getParameter()
    self.raceParams.jumpBonus = config.getParameter()
    self.raceParams.otherBonus = config.getParameter()
end


-- Food related functions

function isVegetarian()
  if (config.getParameter("isVegetarian")==1) then
  end
end

function isCarnivore()
  if (config.getParameter("isCarnivore")==1) then
  end
end

function isOmnivore()
  if (config.getParameter("isOmnivore")==1) then
  end
end

function isRobot()
  if (config.getParameter("isRobot")==1) then
  end
end



-- food allergies

function isAllergy()

end



