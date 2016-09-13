-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys	 = require "Libs/syslib"
local game	 = require "Libs/gamelib"
local Quest	 = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name			= 'SoulBadge'
local description	= 'from Celadon city to get Soul Badge'
local level			= 45

local first_B2F = false
local kill_eevee = false
local leave_lift = false

local dialogs = {
	FujisNotes = Dialog:new({"I went to Pokemon Tower to investigate", "I already read this note."}),
	TowerFinish = Dialog:new({"Thank you for helping me."}),
	SayBye = Dialog:new({"Hey there, I want to thank you again for what you have done for Marowak", "I am wishing the best for you!"})
}
local SoulBadgeQuest = Quest:new()
function SoulBadgeQuest:new()
	return Quest.new(SoulBadgeQuest, name, description, level, dialogs)
end

function SoulBadgeQuest:isDoable()
	if not hasItem("Soul Badge") and self:hasMap() then
		return true
	end
	return false
end

function SoulBadgeQuest:isDone()
	if hasItem("Soul Badge") and getMapName() == "Fuchsia City" then
		return true
	end
	return false
end

function SoulBadgeQuest:CeladonGym()
	if hasItem("RainBow Badge") then
		return moveToMap("Celadon City")
	else
		if isNpcOnCell(8, 4) then
			return talkToNpcOnCell(8, 4)
		end
	end
end

function SoulBadgeQuest:CeladonCity()
	if isNpcOnCell(21, 51) then
		return talkToNpcOnCell(21, 51)
	end
	if self:needPokecenter() then
		return moveToMap("Pokecenter Celadon")
	else
		return moveToMap("Route 7")
	end
end

function SoulBadgeQuest:Route7()
	return moveToMap("Underground House 3")
end

function SoulBadgeQuest:UndergroundHouse3()
	return moveToMap("Underground1")
end

function SoulBadgeQuest:Underground1()
	return moveToMap("Underground House 4")
end

function SoulBadgeQuest:UndergroundHouse4()
	return moveToMap("Route 8")
end

function SoulBadgeQuest:Route8()
	return moveToMap("Lavender Town")
end

function SoulBadgeQuest:PokecenterLavender()
	return self:pokecenter("Lavender Town")
end

function SoulBadgeQuest:PokecenterCeladon()
	return self:pokecenter("Celadon City")
end

function SoulBadgeQuest:LavenderTownVolunteerHouse()
	if isNpcOnCell(10, 10) and not dialogs.FujisNotes.state then
		return talkToNpcOnCell(10, 10)
	elseif isNpcOnCell(8, 5) and not dialogs.SayBye.state then
		return talkToNpcOnCell(8, 5)
	else
		return moveToMap("Lavender Town")
	end
end

function SoulBadgeQuest:PokemonTower1F()
	if not dialogs.TowerFinish.state then
		return moveToMap("Pokemon Tower 2F")
	else
		return moveToMap("Lavender Town")
	end
end

function SoulBadgeQuest:PokemonTower2F()
	if not dialogs.TowerFinish.state then
		return moveToMap("Pokemon Tower 3F")
	else
		return moveToMap("Pokemon Tower 1F")
	end
end

function SoulBadgeQuest:PokemonTower3F()
	if not dialogs.TowerFinish.state then
		return moveToMap("Pokemon Tower 4F")
	else
		return moveToMap("Pokemon Tower 2F")
	end
end

function SoulBadgeQuest:PokemonTower4F()
	if not dialogs.TowerFinish.state then
		return moveToMap("Pokemon Tower 5F")
	else
		return moveToMap("Pokemon Tower 3F")
	end
end

function SoulBadgeQuest:PokemonTower5F()
	if not dialogs.TowerFinish.state then
		return moveToMap("Pokemon Tower 6F")
	else
		return moveToMap("Pokemon Tower 4F")
	end
end

function SoulBadgeQuest:PokemonTower6F()
	if not dialogs.TowerFinish.state and isNpcOnCell(9, 19) then
		return talkToNpcOnCell(9, 19)
	elseif not dialogs.TowerFinish.state then
		return moveToMap("Pokemon Tower 7F")
	else
		return moveToMap("Pokemon Tower 5F")
	end
end

function SoulBadgeQuest:PokemonTower7F()
	if not dialogs.TowerFinish.state and isNpcOnCell(9, 5) then
		return talkToNpcOnCell(9, 5)
	else 
		return moveToMap("Pokemon Tower 6F")
	end
end

function SoulBadgeQuest:LavenderTown()
	if self:needPokecenter() then
		return moveToMap("Pokecenter Lavender")
	elseif not dialogs.FujisNotes.state then
		return moveToCell(10, 12)
	elseif hasItem("Poke Flute") then
		return moveToMap("Route 12")
	else
		return moveToMap("Pokemon Tower 1F")
	end
end

function SoulBadgeQuest:Route12()
	if isNpcOnCell(18, 47) then 
		return talkToNpcOnCell(18, 47)
	else
		return moveToMap("Route 13")
	end
end

function SoulBadgeQuest:Route13()
	return moveToMap("Route 14")
end

function SoulBadgeQuest:Route14()
	return moveToMap("Route 15")
end

function SoulBadgeQuest:Route15()
	return moveToMap("Route 15 Stop House")
end

function SoulBadgeQuest:Route15StopHouse()
	return moveToMap("Fuchsia City")
end

function SoulBadgeQuest:FuchsiaCity()
	if self:needPokecenter() then
		return moveToMap("Pokecenter Fuchsia")
	elseif not self:isTrainingOver() then
		return moveToMap("Route 18")
	else
		return moveToMap("Fuchsia Gym")
	end
end

function SoulBadgeQuest:FuchsiaGym()
	if hasItem("Soul Badge") then
		return moveToMap("Fuchsia City")
	else
		if isNpcOnCell(7, 10) then
			return talkToNpcOnCell(7, 10)
		end
	end
end

function SoulBadgeQuest:Route18()
	if self:needPokecenter() then
		return moveToMap("Fuchsia City")
	elseif not self:isTrainingOver() then
		return moveToGrass()
	else
		return moveToMap("Fuchsia City")
	end
end
function SoulBadgeQuest:PokecenterFuchsia()
	return self:pokecenter("Fuchsia City")
end

return SoulBadgeQuest
