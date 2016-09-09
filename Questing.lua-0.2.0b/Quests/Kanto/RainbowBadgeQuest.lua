-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'RainbowBadge'
local description = 'from Laravendar Town to get RainbowBadge'
local level       = 40

local first_B2F = false

local dialogs = {
    SecurityGuy = Dialog:new({
        "Remember to turn all stones","You better go"
        --""
    }),
    Elevator = Dialog:new({"You have arrived on B4 Floor"}),
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
    if hasItem("Rainbow Badge") and self:hasMap() then
        return true
    end
    return false
end

function RainbowBadgeQuest:RocketHideoutElevator()
    if hasItem("Lift Key") and not dialogs.Elevator.state then
        pushDialogAnswer(3)
        return talkToNpcOnCell(1, 1)
        --first_B2F = true
    end
    if dialogs.Elevator.state then
        return moveToCell(2, 5)--exit eleva
    end
    ---if not first_B2F then
    --   pushDialogAnswer(2)
    --    first_B2F = true
    --   return talkToNpcOnCell(1, 1)
    -- else
    --    moveToCell(2, 5)
    --end
end
function RainbowBadgeQuest:RocketHideoutB2F()
    if hasItem("Lift Key") then
        return moveToCell(31, 19)
    end
    return moveToMap("Rocket Hideout B3F")
end
function RainbowBadgeQuest:RocketHideoutB3F()
    if hasItem("Lift Key") then
        return moveToMap("Rocket Hideout B2F")
    end
    if isNpcOnCell(18, 15) then
        return talkToNpcOnCell(18, 15)
    end
    if isNpcOnCell(15, 22) then
        return talkToNpcOnCell(15, 22)
    else
        return moveToMap("Rocket Hideout B4F")
    end
end
function RainbowBadgeQuest:RocketHideoutB4F()
    if dialogs.Key.state then
        return talkToNpcOnCell(19, 4)
    end
    if isNpcOnCell(5, 6) then
        return talkToNpcOnCell(5, 6)
    end
    if isNpcOnCell(4, 6) then
        talkToNpcOnCell(4, 6)
        return moveToMap("Rocket Hideout B3F")
    else
        return talkToNpcOnCell(18, 15)--use key
    end
end
function RainbowBadgeQuest:RocketHideoutB1F()
    if isNpcOnCell(24, 20) then
        return talkToNpcOnCell(24, 20)
    else
        if isNpcOnCell(23, 20) then
            return talkToNpcOnCell(23,20)
        else
                return moveToMap("Rocket Hideout B2F")
            --return moveToCell(22, 29)
            --return moveToMap("Rocket Hideout Elevator")
        end
    end
end
function RainbowBadgeQuest:CeladonGamecornerStairs()
    if isNpcOnCell(13, 3) then
        return talkToNpcOnCell(13, 3)
     else
        return moveToMap("Rocket Hideout B1F")
    end
end

function RainbowBadgeQuest:CeladonCity()
    if self:needPokecenter() then
        return moveToMap("Pokecenter Celadon")
    elseif not self:isTrainingOver() then
        return moveToMap("Route 7")
    else
        --ready to do quest
        if not dialogs.SecurityGuy.state then
            pushDialogAnswer(2)
            pushDialogAnswer(1)
            pushDialogAnswer(1)
            talkToNpcOnCell(48, 34)
            return
        else
            return moveToMap("Celadon Gamecorner Stairs")
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

return RainbowBadgeQuest
