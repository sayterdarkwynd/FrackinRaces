require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
  animator.setGlobalTag("paletteSwaps", config.getParameter("paletteSwaps", ""))
  animator.setGlobalTag("directives", "")
  animator.setGlobalTag("bladeDirectives", "")

  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, util.toRadians(config.getParameter("baseWeaponRotation", 0)))
  self.weapon:addTransformationGroup("swoosh", {0,0}, math.pi/2)

  local primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(primaryAbility)

  local secondaryAttack = getAltAbility()
  if secondaryAttack then
    self.weapon:addAbility(secondaryAttack)
  end



-- **************************************************
-- FR EFFECTS
-- **************************************************
   if self.meleeCount == nil then 
     self.meleeCount = 0
   end
   if self.meleeCount2 == nil then 
     self.meleeCount2 = 0
   end       

-- if i want to add sword/shield or that sort of thing as a combo pairing/requirement use the below   
--opposedhandHeldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand() == "primary" and "alt" or "primary")   
   
if world.entitySpecies(activeItem.ownerEntityId()) == "hylotl" then  
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "dagger") or root.itemHasTag(heldItem, "hammer") or root.itemHasTag(heldItem, "broadsword") or root.itemHasTag(heldItem, "spear") or root.itemHasTag(heldItem, "axe") then 
       self.meleeCount = self.meleeCount + 1
       status.setPersistentEffects("weaponbonusdmg", {{stat = "protection", amount = self.meleeCount}})  
     end
  end
end

if world.entitySpecies(activeItem.ownerEntityId()) == "floran" then  --florans get defense bonuses when using spears, and increased damage
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "spear") then 
	self.meleeCount = self.meleeCount + 2
	self.meleeCount2 = self.meleeCount2 + 0.14
	status.setPersistentEffects("weaponbonusdmg", {
	  {stat = "protection", amount = self.meleeCount},
	  {stat = "powerMultiplier", amount = self.meleeCount2}
	})   
     end
  end
end

if world.entitySpecies(activeItem.ownerEntityId()) == "glitch" then  --glitch get bonuses with axe and hammer
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "axe") or root.itemHasTag(heldItem, "hammer") then 
	self.meleeCount = self.meleeCount + 0.14
	status.setPersistentEffects("weaponbonusdmg", {
	  {stat = "powerMultiplier", amount = self.meleeCount}
	})   
     end
  end
end

if world.entitySpecies(activeItem.ownerEntityId()) == "human" then  -- Humans do more damage with shortswords and resist knockback
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "shortsword") then 
	  self.meleeCount = self.meleeCount + 0.19
	  status.setPersistentEffects("weaponbonusdmg", {
	    {stat = "powerMultiplier", amount = self.meleeCount},
	    {stat = "grit", amount = self.meleeCount}
	  })   
     end
  end
end

if world.entitySpecies(activeItem.ownerEntityId()) == "wasphive" then   --wasps daggers do 25% more damage
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "dagger") then 
	  self.meleeCount = self.meleeCount + 0.25
	  status.setPersistentEffects("weaponbonusdmg", {{stat = "powerMultiplier", amount = self.meleeCount}})  
     end
  end
end

if world.entitySpecies(activeItem.ownerEntityId()) == "nightar" then  -- Humans do more damage with shortswords and resist knockback
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "shortsword") then 
	  self.meleeCount = self.meleeCount + 0.08
	  status.setPersistentEffects("weaponbonusdmg", {
	    {stat = "powerMultiplier", amount = self.meleeCount},
	    {stat = "grit", amount = self.meleeCount}
	  })   
     end
     if root.itemHasTag(heldItem, "broadsword") then 
	  self.meleeCount = self.meleeCount + 0.18
	  status.setPersistentEffects("weaponbonusdmg", {
	    {stat = "powerMultiplier", amount = self.meleeCount}
	  })  
	  mcontroller.controlModifiers({ speedModifier = 1.15 }) 
     end
  end
end

if world.entitySpecies(activeItem.ownerEntityId()) == "apex" then   --apex love axes and hammers
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "hammer") or root.itemHasTag(heldItem, "axe") then 
	self.meleeCount = 0.19
	status.setPersistentEffects("weaponbonusdmg", {{stat = "powerMultiplier", amount = self.meleeCount}})    	
	mcontroller.controlModifiers({ speedModifier = 1.15 }) 
     end
  end
end  

if world.entitySpecies(activeItem.ownerEntityId()) == "elunite" then   --elunite get defense bonuses with swords
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "dagger") or root.itemHasTag(heldItem, "shortsword") or root.itemHasTag(heldItem, "broadsword") then 
	self.meleeCount = self.meleeCount + 2
	status.setPersistentEffects("weaponbonusdmg", {
	  {stat = "protection", amount = self.meleeCount},
	  {stat = "energyRegenPercentageRate", amount = 0.48}
	}) 
     end
  end
end  


if world.entitySpecies(activeItem.ownerEntityId()) == "fenerox" then  --fenerox get dmg and protection increase with spears
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "spear") then 
	self.meleeCount = self.meleeCount + 1
	self.meleeCount2 = 0.25
	status.setPersistentEffects("weaponbonusdmg", {
	{stat = "protection", amount = self.meleeCount},
	{stat = "powerMultiplier", amount = self.meleeCount2}
	})  
     end
   end
end  

if world.entitySpecies(activeItem.ownerEntityId()) == "viera" then  --viera are dangerous with daggers
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "dagger") then 
	self.meleeCount = self.meleeCount + 1
	self.meleeCount2 = 0.20
	status.setPersistentEffects("weaponbonusdmg", {
	{stat = "protection", amount = self.meleeCount},
	{stat = "powerMultiplier", amount = self.meleeCount2}
	})  
     end
  end
end  

if world.entitySpecies(activeItem.ownerEntityId()) == "vulpes" then  --vulpes get protection when swinging blades
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "dagger") or root.itemHasTag(heldItem, "shortsword") or root.itemHasTag(heldItem, "broadsword") then 
	self.meleeCount = self.meleeCount + 2
	status.setPersistentEffects("weaponbonusdmg", {{stat = "protection", amount = self.meleeCount}})   
     end
  end
end 

 if world.entitySpecies(activeItem.ownerEntityId()) == "sergal" then  --sergal get health and protection with spears
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "spear") then 
	self.meleeCount = self.meleeCount + 2
	status.setPersistentEffects("weaponbonusdmg", {
	{stat = "protection", amount = self.meleeCount},
	{ stat = "maxHealth", baseMultiplier = 1.25 }
	})     
     end
  end
end            

 if world.entitySpecies(activeItem.ownerEntityId()) == "orcana" then  --orcana get health and protection with spears
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "spear") then 
	self.meleeCount = 0.25
	status.setPersistentEffects("weaponbonusdmg", {
	{stat = "powerMultiplier", amount = self.meleeCount},
	{ stat = "maxHealth", baseMultiplier = 1.15 }
	})        
     end
  end
end  

 if world.entitySpecies(activeItem.ownerEntityId()) == "argonian" then  --argonian do extra damage with spears
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "spear") then 
	self.meleeCount = 0.15
	status.setPersistentEffects("weaponbonusdmg", {
	{stat = "powerMultiplier", amount = self.meleeCount},
	{ stat = "maxEnergy", baseMultiplier = 1.25 }
	})        
     end
  end
end  

 if world.entitySpecies(activeItem.ownerEntityId()) == "felin" then  --neko do extra damage with fists, daggers and shortswords
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "fist") or root.itemHasTag(heldItem, "dagger") then 
	self.meleeCount = 0.15
	status.setPersistentEffects("weaponbonusdmg", {{stat = "powerMultiplier", amount = self.meleeCount}})     
     end
  end
end 

 if world.entitySpecies(activeItem.ownerEntityId()) == "neko" then  --neko do extra damage with fists, daggers and shortswords
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "fist") or root.itemHasTag(heldItem, "shortsword") or root.itemHasTag(heldItem, "dagger") then 
	self.meleeCount = 0.15
	status.setPersistentEffects("weaponbonusdmg", {{stat = "powerMultiplier", amount = self.meleeCount}})     
     end
  end
end  

 if world.entitySpecies(activeItem.ownerEntityId()) == "kemono" then   --kemono are brutal with swords
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "dagger") or root.itemHasTag(heldItem, "shortsword") or root.itemHasTag(heldItem, "broadsword") then 
	self.meleeCount = 0.3
	status.setPersistentEffects("weaponbonusdmg", {{stat = "powerMultiplier", amount = self.meleeCount}}) 
     end
  end
end  

 if world.entitySpecies(activeItem.ownerEntityId()) == "avikan" then   --avikan are brutal spears and daggers
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "dagger") or root.itemHasTag(heldItem, "spear") then 
	self.meleeCount = 0.2
	status.setPersistentEffects("weaponbonusdmg", {{stat = "powerMultiplier", amount = self.meleeCount}})   
     end
  end
end  
 
 if world.entitySpecies(activeItem.ownerEntityId()) == "gyrusen" then   --gyrusens are brutal with axes and hammers
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "axe") or root.itemHasTag(heldItem, "hammer") then 
	self.meleeCount = 0.30
	status.setPersistentEffects("weaponbonusdmg", {{stat = "powerMultiplier", amount = self.meleeCount}})   
     end
  end
end  

 if world.entitySpecies(activeItem.ownerEntityId()) == "kazdra" then   --kazdra are brutal with broadswords
  local heldItem = world.entityHandItem(activeItem.ownerEntityId(), activeItem.hand())
  if heldItem then
     if root.itemHasTag(heldItem, "broadsword") then 
	self.meleeCount = 0.30
	status.setPersistentEffects("weaponbonusdmg", {{stat = "powerMultiplier", amount = self.meleeCount}})     
     end
  end
end  
             
-- ***************************************************            
  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
end


function uninit()
  status.clearPersistentEffects("hylotlbonusdmg")
  status.clearPersistentEffects("weaponbonusdmg")
  self.meleeCount = 0
  self.meleeCount2 = 0
  self.weapon:uninit()
end
