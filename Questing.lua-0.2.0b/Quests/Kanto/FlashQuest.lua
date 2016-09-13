-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'Flash'
local description = 'from Route 11 get flash and go to laravendar City'
local level       = 35

local Tunnel1 = false
local Tunnel2 = false
local Tunnel3 = false
local Tunnel4 = false

local dialogs = {
    FlashGuy = Dialog:new({
        "I should return"--,
        --""
    })
}
--dialogs.FlashGuy.state = true
local FlashQuest = Quest:new()
function FlashQuest:new()
    return Quest.new(FlashQuest, name, description, level, dialogs)
end

function FlashQuest:isDoable()
    return self:hasMap()
end

function FlashQuest:isDone()
    return getMapName() == "Pokecenter Lavender"
end

function FlashQuest:Route11()
    if isNpcOnCell(10, 13) then
        return talkToNpcOnCell(10, 13)
    elseif dialogs.FlashGuy.state then
        return moveToMap("Vermilion City")
    else
        return moveToMap("Digletts Cave Entrance 2")
    end
end

function FlashQuest:DiglettsCaveEntrance2()
    if dialogs.FlashGuy.state then
        return moveToMap("Route 11")
    else
        return moveToMap("Digletts Cave")
    end
end
function FlashQuest:DiglettsCave()
    if dialogs.FlashGuy.state then
        return moveToMap("Digletts Cave Entrance 2")
    else
        return moveToMap("Digletts Cave Entrance 1")
    end
end
function FlashQuest:DiglettsCaveEntrance1()
    if dialogs.FlashGuy.state then
        return moveToMap("Digletts Cave")
    else
        return moveToMap("Route 2")
    end
end
function FlashQuest:Route2()
    --log(dialogs.FlashGuy.state)
    if dialogs.FlashGuy.state then
        return moveToMap("Digletts Cave Entrance 1")
    else
        return moveToMap("Route 2 Stop3")
    end
end
function FlashQuest:Route2Stop3()
    if dialogs.FlashGuy.state then
        return moveToMap("Route 2")
    else
        return talkToNpcOnCell(6, 5)
    end
end
function FlashQuest:VermilionCity()
    if dialogs.FlashGuy.state then
        return moveToMap("Route 6")
    else
        return moveToMap("Route 11")
    end
end

function FlashQuest:Route6()
    return moveToMap("Underground House 2")
end
function FlashQuest:UndergroundHouse2()
    return moveToMap("Underground2")
end
function FlashQuest:Underground2()
    return moveToMap("Underground House 1")
end
function FlashQuest:UndergroundHouse1()
    return moveToMap("Route 5")
end
function FlashQuest:Route5()
    return moveToMap("Cerulean City")
end
function FlashQuest:CeruleanCity()
    return moveToMap("Route 9")
end
function FlashQuest:Route9()
    return moveToMap("Route 10")
end
function FlashQuest:Route10()
    if game.inRectangle(4, 44, 6, 46) then
        return moveToMap("Lavender Town")
    end
    if self:needPokecenter()
            or not game.isTeamFullyHealed()
            or self.registeredPokecenter ~= "Pokecenter Route 10"
        then
            return moveToMap("Pokecenter Route 10")
        else
            return moveToMap("Rock Tunnel 1")
        end
end
function FlashQuest:PokecenterRoute10()
    return self:pokecenter("Route 10")
end

function FlashQuest:RockTunnel1()
    if game.inRectangle(6, 6, 9, 7) then
        self.Tunnel2 = true
    end
    if self.Tunnel2 then
		self.Tunnel1 = false
        return moveToCell(8,15)
    end

    if game.inRectangle(5, 28, 9, 30) then
        self.Tunnel2 = false
        self.Tunnel4 = true
    end
    if self.Tunnel4 then
        return moveToCell(21,32)-- Exit Rock Tunnel
    end
    if self:needPokecenter() then
        return moveToMap("Route 10")
    elseif not self:isTrainingOver() then
        return moveToRectangle(41, 7, 43, 10)
    else
        return moveToCell(35,16) -- Rock Tunnel 2
    end
end


function FlashQuest:RockTunnel2()
    if game.inRectangle(36, 14, 40, 20) then
        self.Tunnel1 = true
    end
    if self.Tunnel1 then
        return moveToCell(7,5)
    end
    if game.inRectangle(9, 9, 12, 16) then
        self.Tunnel3 = true
        self.Tunnel1 = false
    end
    if self.Tunnel3 then
		self.Tunnel2 = false
        return moveToCell(8,26)--final exit to tunnel 1
    end
    error("FlashQuest:RockTunnel2(): [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
end
function FlashQuest:LavenderTown()
    return moveToMap("Pokecenter Lavender")
end

return FlashQuest
