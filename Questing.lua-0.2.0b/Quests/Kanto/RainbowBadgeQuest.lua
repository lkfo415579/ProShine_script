-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys	 = require "Libs/syslib"
local game	 = require "Libs/gamelib"
local Quest	 = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'RainbowBadge'
local description = 'from Laravendar Town to get RainbowBadge'
local level		  = 40

local first_B2F = false
local kill_eevee = false

local dialogs = {
	SecurityGuy = Dialog:new({"Remember to turn all stones", "You better go"}),
	Elevator = Dialog:new({"You have arrived on B4 Floor"}),
	ElevatorB1F = Dialog:new({"You have arrived on B1 Floor"}),
	Key = Dialog:new({"You swipe your Card Key"})
}
--dialogs.FlashGuy.state = true
local RainbowBadgeQuest = Quest:new()
function RainbowBadgeQuest:new()
	return Quest.new(RainbowBadgeQuest, name, description, level, dialogs)
end

function RainbowBadgeQuest:isDoable()
	return self:hasMap()
end

function RainbowBadgeQuest:isDone()
	if hasItem("Rainbow Badge") and getMapName() == "Celadon City" then
		return true
	end
	return false
end

function RainbowBadgeQuest:RocketHideoutElevator()
	if hasItem("Silph Scope") then 
		if not dialogs.ElevatorB1F.state then
			pushDialogAnswer(1)
			return talkToNpcOnCell(1, 1)
		else
			return moveToCell(2, 5)--exit eleva
		end
	end
	if hasItem("Lift Key") and not dialogs.Elevator.state then
		pushDialogAnswer(3)
		return talkToNpcOnCell(1, 1)
		--first_B2F = true
	end
	if dialogs.Elevator.state then
		return moveToCell(2, 5)--exit eleva
	end
	---if not first_B2F then
	--	 pushDialogAnswer(2)
	--	  first_B2F = true
	--	 return talkToNpcOnCell(1, 1)
	-- else
	--	  moveToCell(2, 5)
	--end
end
function RainbowBadgeQuest:RocketHideoutB1F()
	log("RainbowBadgeQuest:RocketHideoutB1F(): start")
	if hasItem("Silph Scope") and not game.inRectangle(1, 17, 7, 22) then
		moveToMap("Celadon Gamecorner Stairs")
	else
		if not game.inRectangle(6, 18, 6, 18) then
			return moveToCell(6, 18)
		elseif game.inRectangle(6, 18, 6, 18) then
			return talkToNpcOnCell(7, 18)
		end
	end
	if isNpcOnCell(24, 20) then
		log("RainbowBadgeQuest:RocketHideoutB1F(): if isNpcOnCell(24, 20)")
		return talkToNpcOnCell(24, 20)
	elseif isNpcOnCell(23, 20) then
		log("RainbowBadgeQuest:RocketHideoutB1F(): if isNpcOnCell(23, 20)")
		return talkToNpcOnCell(23, 20)
	elseif game.inRectangle(1, 17, 7, 22) then --close area
		if not game.inRectangle(6, 18, 6, 18) then
			return moveToCell(6, 18)
		elseif game.inRectangle(6, 18, 6, 18) then
			return talkToNpcOnCell(7, 18)
			--return talkToNpcOnCell(7,22) --doctor before jump out
		end
	else
		return moveToMap("Rocket Hideout B2F")
		--moveToCell(22, 29)
		--return moveToCell(17, 9)
		--return moveToCell(22, 29)
		--return moveToMap("Rocket Hideout Elevator")
	end
end
function RainbowBadgeQuest:RocketHideoutB2F()
	if not kill_eevee then
		return moveToCell(23, 4)
	elseif isNpcOnCell(28, 20) then
		return talkToNpcOnCell(28, 20)
	elseif hasItem("Lift Key") then
		return moveToCell(31, 19)
	end
	return moveToMap("Rocket Hideout B3F")
end
function RainbowBadgeQuest:RocketHideoutB3F()
	if isNpcOnCell(19, 6) then
		return talkToNpcOnCell(19, 6)
	end
	if isNpcOnCell(18, 15) then
		return talkToNpcOnCell(18, 15)
	else
		kill_eevee = true
	end
	if isNpcOnCell(15, 22) then
		return talkToNpcOnCell(15, 22)
	elseif not hasItem("Card Key") then
		return moveToMap("Rocket Hideout B4F")
	else
		return moveToMap("Rocket Hideout B2F")
	end
end
function RainbowBadgeQuest:RocketHideoutB4F()
	if hasItem("Silph Scope") and game.inRectangle(15, 1, 30, 15) then
		return talkToNpcOnCell(18, 15)--use key
	elseif hasItem("Silph Scope") then
		return moveToCell(20, 25) --use Elevator back to B1F
	end
	--after beat the boss, take the glass on the table
	if not isNpcOnCell(19, 4) and isNpcOnCell(18, 6) then
		return talkToNpcOnCell(18, 6) --take the glass
	end
	if dialogs.Key.state then
		return talkToNpcOnCell(19, 4)
	end
	if isNpcOnCell(5, 6) then
		return talkToNpcOnCell(5, 6)
	end
	if isNpcOnCell(4, 6) then
		return talkToNpcOnCell(4, 6)
	elseif not isNpcOnCell(4, 6) and game.inRectangle(1, 1, 16, 30) then
		return moveToMap("Rocket Hideout B3F")
	elseif isNpcOnCell(18, 15) and hasItem("Card Key") then
		return talkToNpcOnCell(18, 15)--use key
	end
end
function RainbowBadgeQuest:CeladonGamecornerStairs()
	if isNpcOnCell(13, 3) then
		return talkToNpcOnCell(13, 3)
	elseif hasItem("Silph Scope") then
		moveToMap("Celadon City")
	else
		return moveToMap("Rocket Hideout B1F")
	end
end

function RainbowBadgeQuest:CeladonCity()
	if self:needPokecenter() then
		return moveToMap("Pokecenter Celadon")
	elseif not self:isTrainingOver() then
		return moveToMap("Route 7")
	elseif not hasItem("Silph Scope") then
		--ready to do quest
		if not dialogs.SecurityGuy.state then
			pushDialogAnswer(2)
			pushDialogAnswer(1)
			pushDialogAnswer(1)
			return talkToNpcOnCell(48, 34)
		else
			return moveToMap("Celadon Gamecorner Stairs")
		end
	else --go to get the Badge
		if isNpcOnCell(46, 49) then
			return talkToNpcOnCell(46, 49)
		else 
			return moveToMap("CeladonGym")
		end
	end
end

function RainbowBadgeQuest:CeladonGym()
	--self.printNpcMap()
	if hasItem("RainBow Badge") then
		return moveToMap("Celadon City")
	else
		if isNpcOnCell(8, 4) then
			return talkToNpcOnCell(8, 4)
		end
	end
end

function RainbowBadgeQuest:Route7()
	if self:needPokecenter() then
		return moveToMap("Celadon City")
	elseif not self:isTrainingOver() then
		return moveToGrass()
	else
		return moveToMap("Celadon City")
	end
end

function RainbowBadgeQuest:UndergroundHouse3()
	return moveToMap("Route 7")
end

function RainbowBadgeQuest:Underground1()
	return moveToMap("Underground House 3")
end

function RainbowBadgeQuest:UndergroundHouse4()
	return moveToMap("Underground1")
end

function RainbowBadgeQuest:Route8()
	return moveToMap("Underground House 4")
end

function RainbowBadgeQuest:PokecenterLavender()
	return self:pokecenter("Lavender Town")
end

function RainbowBadgeQuest:PokecenterCeladon()
	return self:pokecenter("Celadon City")
end

function RainbowBadgeQuest:LavenderTown()
	return moveToMap("Route 8")
end

function RainbowBadgeQuest:printNpcMap()
	-- find all npc in the map
	range_i_from = 1
	range_i_to = 25
	range_j_from = 1
	range_j_to = 25
	
	tmp_result = 'i=■'
	for i = range_i_from, range_i_to do
		if i % 10 == 5 or i % 10 == 0 then
			tmp_result = tmp_result .. '■'
		else 
			tmp_result = tmp_result .. '□'
		end
	end
	log(tmp_result)
	
	for j = range_j_from, range_j_to do 
		i_result = 'j='..j % 10
		for i = range_i_from, range_i_to do 
			if isNpcOnCell(i, j) then 
				i_result = i_result .. '■'
			else
				i_result = i_result .. '□'
			end 
		end
		log(i_result)
	end 
	
	for j = range_j_from, range_j_to do 
		i_result = ''
		for i = range_i_from, range_i_to do 
			if isNpcOnCell(i, j) then 
				log("Npc on "..i..","..j)
			end
		end
	end 
	error("stop")
end

return RainbowBadgeQuest
