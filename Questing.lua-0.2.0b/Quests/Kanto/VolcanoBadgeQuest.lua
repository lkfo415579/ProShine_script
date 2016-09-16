-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys	 = require "Libs/syslib"
local game	 = require "Libs/gamelib"
local Quest	 = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name			= 'VolcanoBadgeQuest'
local description	= 'from Celadon city to get Volcano Badge'
local level			= 70

local dialogs = {
	FujisNotes = Dialog:new({"I went to Pokemon Tower to investigate", "I already read this note."})
}
local VolcanoBadgeQuest = Quest:new()
function VolcanoBadgeQuest:new()
	return Quest.new(VolcanoBadgeQuest, name, description, level, dialogs)
end

function VolcanoBadgeQuest:isDoable()
	if not hasItem("Volcano Badge") and self:hasMap() then
		return true
	end
	return false
end

function VolcanoBadgeQuest:isDone()
	if hasItem("Volcano Badge") and getMapName() == "Fuchsia City" then
		return true
	end
	return false
end

function VolcanoBadgeQuest:FuchsiaCity()
	if self:needPokecenter() then
		return moveToMap("Pokecenter Fuchsia")
	else
		return moveToMap("Route 8 Stop House")
	end
end

function VolcanoBadgeQuest:PokecenterFuchsia()
	return self:pokecenter("Fuchsia City")
end

function VolcanoBadgeQuest:Route8StopHouse()
	return moveToMap("Route 8")
end

function VolcanoBadgeQuest:Route8()
	return moveToMap("Lavender Town")
end

function VolcanoBadgeQuest:LavenderTown()
	return moveToMap("Route 12")
end

function VolcanoBadgeQuest:Route12()
	return moveToMap("Route 13")
end

function VolcanoBadgeQuest:Route13()
	return moveToMap("Route 14")
end

function VolcanoBadgeQuest:Route14()
	return moveToMap("Route 15")
end

function VolcanoBadgeQuest:Route15()
	return moveToMap("Route 15 Stop House")
end

function VolcanoBadgeQuest:Route15StopHouse()
	return moveToMap("Fuchsia City")
end

function VolcanoBadgeQuest:FuchsiaCity()
	if self:needPokecenter() then
		return moveToMap("Pokecenter Fuchsia")
	elseif not self:isTrainingOver() then
		return moveToMap("Fuchsia City Stop House")
	else
		return moveToMap("Fuchsia City Stop House")
	end
end

function VolcanoBadgeQuest:FuchsiaCityStopHouse()
	if self:needPokecenter() then
		return moveToMap("Fuchsia City")
	elseif game.hasPokemonWithMove("Surf") and not self:isTrainingOver() then
		return moveToMap("Route 19")
	else
		return moveToMap("Route 19")
	end
end

function VolcanoBadgeQuest:Route19()
	if self:needPokecenter() then
		return moveToMap("Fuchsia City Stop House")
	elseif game.hasPokemonWithMove("Surf") and not self:isTrainingOver() then
		return moveToWater()
	else
		return moveToMap("Route 20")
	end
end

function VolcanoBadgeQuest:PokecenterFuchsia()
	return self:pokecenter("Fuchsia City")
end

return VolcanoBadgeQuest
