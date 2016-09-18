-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys	 = require "Libs/syslib"
local game	 = require "Libs/gamelib"
local Quest	 = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name			= 'EarthBadgeQuest'
local description	= 'from Saffron city to get Volcano Badge'
local level			= 90

local saveRespawnPoint = false

local dialogs = {
	Nothing = Dialog:new({""})
}
local EarthBadgeQuest = Quest:new()
function EarthBadgeQuest:new()
	return Quest.new(EarthBadgeQuest, name, description, level, dialogs)
end

function EarthBadgeQuest:isDoable()
	if not hasItem("Earth Badge") and self:hasMap() then
		return true
	end
	return false
end

function EarthBadgeQuest:isDone()
	if hasItem("Earth Badge") and getMapName() == "Cinnabar Island" then
		return true
	end
	return false
end

function EarthBadgeQuest:Route20()
	if self:isTrainingOver() then
		if game.inRectangle(49, 38, 78, 44) then
			return moveToCell(48, 41)
		elseif game.inRectangle(1, 1, 49, 44) then
			return moveToMap("Cinnabar Island")
		else
			return moveToCell(60, 32) -- enter seafoam 1F (left)
		end
	else
		if game.inRectangle(0, 0, 49, 44) then
			if self:needPokecenter() then
				return moveToMap("Cinnabar Island")
			else
				return moveToWater()
			end
		else
			return moveToMap("Cinnabar Island")
		end
	end
end

function EarthBadgeQuest:CinnabarIsland()
	if not saveRespawnPoint or self:needPokecenter() then
		return moveToMap("Pokecenter Cinnabar")
	elseif getItemQuantity("Great Ball") < 50 and getMoney() >= 600 then
		return moveToMap("Cinnabar Pokemart")
	elseif not self:isTrainingOver() then
		return moveToMap("Route 20")
	end
end

function EarthBadgeQuest:CinnabarPokemart()
	local pokeballCount = getItemQuantity("Great Ball")
	local money         = getMoney()
	if money >= 600 and pokeballCount < 50 then
		if not isShopOpen() then
			return talkToNpcOnCell(3,5)
		else
			local pokeballToBuy = 50 - pokeballCount
			local maximumBuyablePokeballs = money / 600
			if maximumBuyablePokeballs < pokeballToBuy then
				pokeballToBuy = maximumBuyablePokeballs
			end
			return buyItem("Great Ball", pokeballToBuy)
		end
	else
		return moveToMap("Cinnabar Island")
	end
end

function EarthBadgeQuest:PokecenterCinnabar()
	saveRespawnPoint = true
	return self:pokecenter("Cinnabar Island")
end

function EarthBadgeQuest:CinnabarGym()
	if not hasItem("Volcano Badge") then
		if isNpcOnCell(6, 7) then
			if not game.inRectangle(6, 8, 6, 8) then
				return moveToCell(6, 8)
			else
				return talkToNpcOnCell(6, 7)
			end
		elseif not game.inRectangle(6, 12, 6, 12) then
			return moveToCell(6, 12)
		else
			return moveToCell(6, 5)
		end
	else
		return moveToMap("Cinnabar Island")
	end
end

function EarthBadgeQuest:CinnabarGymB1F()
	if not hasItem("Volcano Badge") then
		if isNpcOnCell(18, 16) then
			return talkToNpcOnCell(18, 16)
		end
	else
		return moveToCell(7, 5)
	end
end

return EarthBadgeQuest
