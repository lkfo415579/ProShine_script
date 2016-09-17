-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys	 = require "Libs/syslib"
local game	 = require "Libs/gamelib"
local Quest	 = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name			= 'VolcanoBadgeQuest'
local description	= 'from Saffron city to get Volcano Badge'
local level			= 70

local saveRespawnPoint = false

local dialogs = {
	GymGuy = Dialog:new({"I see you have earned your Marsh Badge"})
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
	if hasItem("Volcano Badge") and getMapName() == "Cinnabar Island" then
		return true
	end
	return false
end

function VolcanoBadgeQuest:SaffronCity()
	if self:needPokecenter() then
		return moveToMap("Pokecenter Saffron")
	else
		return moveToMap("Route 8 Stop House")
	end
end

function VolcanoBadgeQuest:PokecenterSaffron()
	return self:pokecenter("Saffron City")
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

function VolcanoBadgeQuest:PokecenterFuchsia()
	return self:pokecenter("Fuchsia City")
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

function VolcanoBadgeQuest:Route20()
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
			return moveToMap("Route 19")
		end
	end
end

function VolcanoBadgeQuest:Seafoam1F()
	if game.inRectangle(64, 7, 77, 15) then
		return moveToCell(71, 15) -- go to Route 20 down
	else
		return moveToCell(20, 8) -- enter seafoam B1F (left)
	end
end

function VolcanoBadgeQuest:SeafoamB1F()
	return moveToCell(85, 22)
end

function VolcanoBadgeQuest:CinnabarIsland()
	if not saveRespawnPoint or self:needPokecenter() then
		return moveToMap("Pokecenter Cinnabar")
	elseif not self:isTrainingOver() then
		return moveToMap("Route 20")
	elseif not hasItem("Cinnabar Key") and isNpcOnCell(28, 17) then
		-- Cinnabar quest
		if isNpcOnCell(18, 15) then
			return talkToNpcOnCell(18, 15)
		elseif not isNpcOnCell(18, 15) then
			return moveToMap("Cinnabar mansion 1")
		end
	elseif hasItem("Cinnabar Key") and isNpcOnCell(28, 17) then
		return talkToNpcOnCell(28, 17)
	elseif not hasItem("Volcano Badge") then
		return moveToMap("Cinnabar Gym")
	end
end

function VolcanoBadgeQuest:PokecenterCinnabar()
	saveRespawnPoint = true
	return self:pokecenter("Cinnabar Island")
end

function VolcanoBadgeQuest:Cinnabarmansion1()
	if game.inRectangle(0, 0, 28, 42) then --entrance
		return moveToMap("Cinnabar mansion 2")
	else
		return moveToCell(39, 42)
	end
end

function VolcanoBadgeQuest:Cinnabarmansion2()
	if game.inRectangle(0, 0, 18, 25) then --entrance
		return moveToCell(9, 4)
	end
end

function VolcanoBadgeQuest:Cinnabarmansion3()
	if not game.inRectangle(21, 18, 21, 18) then
		return moveToCell(21, 18)
	else
		return moveToCell(21, 19) -- Fall to Cinnabar mansion B1F
	end
end

function VolcanoBadgeQuest:CinnabarmansionB1F()
	if isNpcOnCell(5, 19) then
		return talkToNpcOnCell(5, 19)
	elseif isNpcOnCell(5, 15) then
		return talkToNpcOnCell(5, 15)
	else
		return moveToCell(36, 30)
	end
end

function VolcanoBadgeQuest:CinnabarGym()
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

function VolcanoBadgeQuest:CinnabarGymB1F()
	if not hasItem("Volcano Badge") then
		if isNpcOnCell(18, 16) then
			return talkToNpcOnCell(18, 16)
		end
	else
		return moveToCell(7, 5)
	end
end

return VolcanoBadgeQuest
