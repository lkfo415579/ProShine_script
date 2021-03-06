 -- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys	 = require "Libs/syslib"
local game	 = require "Libs/gamelib"
local Quest	 = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name			= 'MarshBadge'
local description	= 'from Fuchsia city to get Marsh Badge'
local level			= 55

local pokemonId = 1
local isBattleSaffronBoss = false
local saveRespawnPoint = false

local dialogs = {
	BattlePikachu = Dialog:new({"Hey dude, did you come to see my totally rad Pikachu", "Did you get the HM broseph?"})
}
local MarshBadgeQuest = Quest:new()
function MarshBadgeQuest:new()
	return Quest.new(MarshBadgeQuest, name, description, level, dialogs)
end

function MarshBadgeQuest:isDoable()
	if not hasItem("Marsh Badge") and self:hasMap() then
		return true
	end
	return false
end

function MarshBadgeQuest:isDone()
	if hasItem("Marsh Badge") and getMapName() == "Saffron City" then
		return true
	end
	return false
end

function MarshBadgeQuest:FuchsiaGym()
	if hasItem("Soul Badge") then
		return moveToMap("Fuchsia City")
	else
		if isNpcOnCell(7, 10) then
			return talkToNpcOnCell(7, 10)
		end
	end
end

function MarshBadgeQuest:FuchsiaCity()
	if self:needPokecenter() then
		return moveToMap("Pokecenter Fuchsia")
	elseif game.hasPokemonWithMove("Surf") and not self:isTrainingOver() then
		return moveToMap("Fuchsia City Stop House")
	elseif not hasItem("HM03 - Surf") then
		log("going to get HM03")
		if not dialogs.BattlePikachu.state then
			return moveToMap("Fuchsia City Stop House")
		elseif dialogs.BattlePikachu.state then
			return moveToMap("Safari Stop")
		end
	elseif hasItem("HM03 - Surf") then
		return moveToMap("Route 15 Stop House")
	end
end

function MarshBadgeQuest:PokecenterFuchsia()
	return self:pokecenter("Fuchsia City")
end

function MarshBadgeQuest:FuchsiaCityStopHouse()
	if self:needPokecenter() then
		return moveToMap("Fuchsia City")
	elseif game.hasPokemonWithMove("Surf") and not self:isTrainingOver() then
		return moveToMap("Route 19")
	end
	
	if not dialogs.BattlePikachu.state then
		return moveToMap("Route 19")
	else
		return moveToMap("Fuchsia City")
	end
end

function MarshBadgeQuest:Route19()
	if self:needPokecenter() then
		return moveToMap("Fuchsia City Stop House")
	elseif game.hasPokemonWithMove("Surf") and not self:isTrainingOver() then
		return moveToWater()
	end
	
	if isNpcOnCell(33, 19) and not dialogs.BattlePikachu.state then
		return talkToNpcOnCell(33, 19)
	else
		return moveToMap("Fuchsia City Stop House")
	end
end

function MarshBadgeQuest:Route20()
	return moveToMap("Route 19")
end

-- Safari to get HM03
function MarshBadgeQuest:SafariStop()
	if not hasItem("HM03 - Surf") and isNpcOnCell(6, 4) then
		return talkToNpcOnCell(6, 4)
	else
		return moveToMap("Fuchsia City")
	end
end

function MarshBadgeQuest:SafariEntrance()
	if not hasItem("HM03 - Surf") then
		return moveToMap("Safari Area 1")
	elseif isNpcOnCell(27, 25) then
		return talkToNpcOnCell(27, 25)
	end
end

function MarshBadgeQuest:SafariArea1()
	return moveToMap("Safari Area 2")
end

function MarshBadgeQuest:SafariArea2()
	return moveToMap("Safari Area 3")
end

function MarshBadgeQuest:SafariArea3()
	if not hasItem("HM03 - Surf") then
		return moveToMap("Safari House 4")
	else
		return moveToMap("Safari Entrance")
	end
end

function MarshBadgeQuest:SafariHouse4()
	if isNpcOnCell(11, 3) then
		return talkToNpcOnCell(11, 3)
	elseif hasItem("HM03 - Surf") then
		--teach pokemon to learn surf in the room
		if game.hasPokemonWithMove("Surf") then
			return moveToMap("Safari Area 3")
		else
			if pokemonId < getTeamSize() then
				useItemOnPokemon("HM03 - Surf", pokemonId)
				log("Pokemon: " .. pokemonId .. " Try Learning: HM03 - Surf")
				pokemonId = pokemonId + 1
			else
				fatal("No pokemon in this team can learn - Surf")
			end
		end
	else
		return moveToMap("Safari Area 3")
	end
end

-- Celadon City go to buy drink
function MarshBadgeQuest:CeladonCity()
	if self:needPokecenter() then
		return moveToMap("Pokecenter Celadon")
	elseif not hasItem("Lemonade") then
		return moveToMap("Celadon Mart 1")
	elseif not self:isTrainingOver() and not self:needPokecenter() then
		return moveToRectangle(30, 36, 34, 38)
	else
		return moveToMap("Route 7")
	end
end

function MarshBadgeQuest:PokecenterCeladon()
	return self:pokecenter("Celadon City")
end

function MarshBadgeQuest:CeladonMart1()
	if not game.inRectangle(5, 11, 5, 11) then
		return moveToCell(5, 11)
	end
	if not hasItem("Lemonade") then
		return moveToMap("Celadon Mart 2")
	else
		return moveToMap("Celadon City") -- Why bot stop here?
	end
end

function MarshBadgeQuest:CeladonMart2()
	if not hasItem("Lemonade") then
		return moveToMap("Celadon Mart 3")
	else
		return moveToMap("Celadon Mart 1")
	end
end

function MarshBadgeQuest:CeladonMart3()
	if not hasItem("Lemonade") then
		return moveToMap("Celadon Mart 4")
	else
		return moveToMap("Celadon Mart 2")
	end
end

function MarshBadgeQuest:CeladonMart4()
	if not hasItem("Lemonade") then
		return moveToMap("Celadon Mart 5")
	else
		return moveToMap("Celadon Mart 3")
	end
end

function MarshBadgeQuest:CeladonMart5()
	if not hasItem("Lemonade") then
		return moveToMap("Celadon Mart 6")
	else
		return moveToMap("Celadon Mart 4")
	end
end

function MarshBadgeQuest:CeladonMart6()
	--self:printNpcMap()
	if not hasItem("Lemonade") then
		local money = getMoney()
		if money >= 700 then
			if not isShopOpen() then
				talkToNpcOnCell(16, 7)
			else
				return buyItem("Lemonade", 2)
			end
		else
			fatal("What!? You don't even have 700 dollars, I cannot help you anymore. Make 700 dollars and start again. Orz ")
		end
	else
		return moveToMap("Celadon Mart 5")
	end
end

-- Saffron City quest
function MarshBadgeQuest:Route7()
	if not hasItem("Lemonade") and not saveRespawnPoint then
		return moveToMap("Celadon City")
	elseif not self:isTrainingOver() then
		return moveToMap("Celadon City")
	else
		return moveToMap("Route 7 Stop House")
	end
end

function MarshBadgeQuest:Route7StopHouse()
	if saveRespawnPoint and not self:isTrainingOver() and not self:needPokecenter() then
		return moveToMap("Route 7")
	else
		return moveToMap("Saffron City")
	end
end

function MarshBadgeQuest:SaffronCity()
	if not saveRespawnPoint then
		return moveToMap("Pokecenter Saffron")
	elseif self:needPokecenter() then
		return moveToMap("Pokecenter Saffron")
	elseif not self:isTrainingOver() then
		return moveToMap("Route 7 Stop House")
	elseif isNpcOnCell(49, 14) then
		isBattleSaffronBoss = false
		return moveToMap("Silph Co 1F")
	else --ready to beat gym boss
		return moveToMap("Saffron Gym")
	end
end

function MarshBadgeQuest:PokecenterSaffron()
	saveRespawnPoint = true
	return self:pokecenter("Saffron City")
end

function MarshBadgeQuest:SilphCo1F()
	if not isBattleSaffronBoss then
		return moveToMap("Silph Co 2F")
	else
		return moveToMap("Saffron City")
	end
end

function MarshBadgeQuest:SilphCo2F()
	if not isBattleSaffronBoss then
		return moveToMap("Silph Co 3F")
	else
		return moveToMap("Silph Co 1F")
	end
end

function MarshBadgeQuest:SilphCo3F()
	if not isBattleSaffronBoss then
		return moveToCell(16, 18)
	else
		return moveToMap("Silph Co 2F")
	end
end

function MarshBadgeQuest:SilphCo7F()
	if not isBattleSaffronBoss then
		return moveToCell(6, 11)
	else
		return moveToCell(6, 6)
	end
end

function MarshBadgeQuest:SilphCo11F()
	if not isBattleSaffronBoss then
		if isNpcOnCell(3, 13) then
			return talkToNpcOnCell(3, 13)
		elseif isNpcOnCell(6, 15) then
			return talkToNpcOnCell(6, 15)
		elseif isNpcOnCell(9, 11) then
			isBattleSaffronBoss = true
			return talkToNpcOnCell(9, 11)
		end
	else
		return moveToCell(3, 7)
	end
end

function MarshBadgeQuest:SaffronGym()
	if not hasItem("Marsh Badge") then
		if game.inRectangle(9, 16, 15, 22) then --entrance
			return moveToCell(15, 17)
		elseif game.inRectangle(17, 16, 23, 20) then --right bottom
			return moveToCell(18, 20)
		elseif game.inRectangle(1, 16, 7, 20) then --left bottom
			return moveToCell(6, 20)
		elseif game.inRectangle(1, 9, 7, 13) then
			return moveToCell(2, 13)
		elseif game.inRectangle(1, 2, 7, 6) then
			return moveToCell(2, 6)
		elseif game.inRectangle(9, 9, 15, 13) then
			if isNpcOnCell(12, 10) then
				return talkToNpcOnCell(12, 10)
			end
		end
	else
		if game.inRectangle(9, 9, 15, 13) then
			return moveToCell(10, 13)
		elseif game.inRectangle(9, 16, 15, 22) then --entrance
			return moveToMap("Saffron City")
		end
	end
end

-- From Fuchsia to Celadon
function MarshBadgeQuest:UndergroundHouse3()
	return moveToMap("Route 7")
end

function MarshBadgeQuest:Underground1()
	return moveToMap("Underground House 3")
end

function MarshBadgeQuest:UndergroundHouse4()
	return moveToMap("Underground1")
end

function MarshBadgeQuest:Route8()
	return moveToMap("Underground House 4")
end

function MarshBadgeQuest:LavenderTown()
	return moveToMap("Route 8")
end

function MarshBadgeQuest:Route12()
	return moveToMap("Lavender Town")
end

function MarshBadgeQuest:Route13()
	return moveToMap("Route 12")
end

function MarshBadgeQuest:Route14()
	return moveToMap("Route 13")
end

function MarshBadgeQuest:Route15()
	return moveToMap("Route 14")
end

function MarshBadgeQuest:Route15StopHouse()
	return moveToMap("Route 15")
end

return MarshBadgeQuest
