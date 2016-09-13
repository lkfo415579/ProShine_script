-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys  = require "Libs/syslib"
local game = require "Libs/gamelib"

local blacklist = require "blacklist"

local Quest = {}

function Quest:new(name, description, level, dialogs)
	local o = {}
	setmetatable(o, self)
	self.__index     = self
	o.name        = name
	o.description = description
	o.level       = level or 1
	o.dialogs     = dialogs
	o.training    = true
	return o
end

function Quest:isDoable()
	sys.error("Quest:isDoable", "function is not overloaded in quest: " .. self.name)
	return nil
end

function Quest:isDone()
	return self:isDoable() == false
end

function Quest:mapToFunction()
	local mapName = getMapName()
	local mapFunction = sys.removeCharacter(mapName, ' ')
	mapFunction = sys.removeCharacter(mapFunction, '.')
	return mapFunction
end

function Quest:hasMap()
	local mapFunction = self:mapToFunction()
	if self[mapFunction] then
		return true
	end
	return false
end

function Quest:pokecenter(exitMapName) -- idealy make it work without exitMapName
	self.registeredPokecenter = getMapName()
	sys.todo("add a moveDown() or moveToNearestLink() or getLinks() to PROShine")
	if not game.isTeamFullyHealed() then
		return usePokecenter()
	end
	return moveToMap(exitMapName)
end

-- at a point in the game we'll always need to buy the same things
-- use this function then
function Quest:pokemart(exitMapName)
	local pokeballCount = getItemQuantity("Pokeball")
	local money         = getMoney()
	if money >= 200 and pokeballCount < 50 then
		if not isShopOpen() then
			return talkToNpcOnCell(3,5)
		else
			local pokeballToBuy = 50 - pokeballCount
			local maximumBuyablePokeballs = money / 200
			if maximumBuyablePokeballs < pokeballToBuy then
				pokeballToBuy = maximumBuyablePokeballs
			end
			return buyItem("Pokeball", pokeballToBuy)
		end
	else
		return moveToMap(exitMapName)
	end
end

function Quest:isTrainingOver()
	if game.minTeamLevel() >= self.level then
		if self.training then -- end the training
			self:stopTraining()
		end
		return true
	end
	return false
end

function Quest:leftovers()
	ItemName = "Leftovers"
	local PokemonNeedLeftovers = game.getFirstUsablePokemon()
	local PokemonWithLeftovers = game.getPokemonIdWithItem(ItemName)
	
	if PokemonWithLeftovers > 0 then
		if PokemonNeedLeftovers == PokemonWithLeftovers  then
			return false -- now leftovers is on rightpokemon
		else
			takeItemFromPokemon(PokemonWithLeftovers)
			return true
		end
	else
		if hasItem(ItemName) then
			giveItemToPokemon(ItemName,PokemonNeedLeftovers)
			return true
		else
			return false-- don't have leftovers in bag and is not on pokemons
		end
	end
end

function Quest:startTraining()
	self.training = true
end

function Quest:stopTraining()
	self.training = false
	self.healPokemonOnceTrainingIsOver = true
end

function Quest:needPokemart()
	-- TODO: ItemManager
	if getItemQuantity("Pokeball") < 50 and getMoney() >= 200 then
		return true
	end
	return false
end

function Quest:needPokecenter()
	if getTeamSize() == 1 then
		if getPokemonHealthPercent(1) <= 50 then
			return true
		end
	-- else we would spend more time evolving the higher level ones
	elseif not self:isTrainingOver() then
		if getUsablePokemonCount() <= 1 or game.getUsablePokemonCountUnderLevel(self.level) == 0
		then
			return true
		end
	else
		if not game.isTeamFullyHealed() then
			if self.healPokemonOnceTrainingIsOver then
				return true
			end
		else
			-- the team is healed and we do not need training
			self.healPokemonOnceTrainingIsOver = false
		end
	end
	return false
end

function Quest:message()
	return self.name .. ': ' .. self.description
end

-- I'll need a TeamManager class very soon
local moonStoneTargets = {
	"Clefairy",
	"Jigglypuff",
	"Munna",
	"Nidorino",
	"Nidorina",
	"Skitty"
}

function Quest:evolvePokemon()
	local hasMoonStone = hasItem("Moon Stone")
	for pokemonId=1, getTeamSize(), 1 do
		local pokemonName = getPokemonName(pokemonId)
		if hasMoonStone
			and sys.tableHasValue(moonStoneTargets, pokemonName)
		then
			return useItemOnPokemon("Moon Stone", pokemonId)
		end
	end
	return false
end

function Quest:path()
	if self.inBattle then
		self.inBattle = false
		self:battleEnd()
	end
	if self:evolvePokemon() then
		return true
	end
	if not isTeamSortedByLevelAscending() then
		return sortTeamByLevelAscending()
	end
	if self:leftovers() then
		return true
	end
	local mapFunction = self:mapToFunction()
	assert(self[mapFunction] ~= nil, self.name .. " quest has no method for map: " .. getMapName())
	self[mapFunction](self)
end

function Quest:isPokemonBlacklisted(pokemonName)
	return sys.tableHasValue(blacklist, pokemonName)
end

function Quest:battleBegin()
	self.canRun = true
end

function Quest:battleEnd()
	self.canRun = true
end

function Quest:wildBattle()
	if isOpponentShiny() then
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return true
		end
	elseif not isAlreadyCaught() and getOpponentHealthPercent() < 50 then --not catch Hoothoot, it cause pokecenter heal loop
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return true
		end
	end
	
	-- if we do not try to catch it
	if getTeamSize() == 1 or getUsablePokemonCount() > 1 then
		local opponentLevel = getOpponentLevel()
		local myPokemonLvl  = getPokemonLevel(getActivePokemonNumber())
		if opponentLevel >= myPokemonLvl then
			local requestedId, requestedLevel = game.getMaxLevelUsablePokemon()
			if requestedId ~= nil and requestedLevel > myPokemonLvl then
				return sendPokemon(requestedId)
			end
		end
		return attack() or sendUsablePokemon() or run() or sendAnyPokemon()
	else
		if not self.canRun then
			return attack() or game.useAnyMove()
		end
		return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
	end
end

function Quest:trainerBattle()
	-- bug: if last pokemons have only damaging but type ineffective
	-- attacks, then we cannot use the non damaging ones to continue.
	if not self.canRun then -- trying to switch while a pokemon is squeezed end up in an infinity loop
		return attack() or game.useAnyMove()
	end
	return attack() or sendUsablePokemon() or sendAnyPokemon() -- or game.useAnyMove()
end

function Quest:battle()
	if not self.inBattle then
		self.inBattle = true
		self:battleBegin()
	end
	if isWildBattle() then
		return self:wildBattle()
	else
		return self:trainerBattle()
	end
end

function Quest:dialog(message)
	if self.dialogs == nil then
		return false
	end
	for _, dialog in pairs(self.dialogs) do
		if dialog:messageMatch(message) then
			dialog.state = true
			return true
		end
	end
	return false
end

function Quest:battleMessage(message)
	if sys.stringContains(message, "You can not run away!") then
		sys.canRun = false
	elseif sys.stringContains(message, "black out") and self.level < 100 and self:isTrainingOver() then
		self.level = self.level + 1
		self:startTraining()
		log("Increasing " .. self.name .. " quest level to " .. self.level .. ". Training time!")
		return true
	end
	return false
end

function Quest:systemMessage(message)
	return false
end

local hmMoves = {
	"cut",
	"surf",
	"flash",
	--move with Acc 100%, Power >= 40, <= 100
	"Pound", "Pay Day", "Scratch", "Gust", "Acid", "Ember", "Water Gun", "Mega Drain", "Thunder Shock", "Quick Attack", "Bubble", "Powder Snow", "Mach Punch", "False Swipe", "Pursuit", "Twister", "Rock Smash", "Fake Out", "Vacuum Wave", "Bullet Punch", "Ice Shard", "Shadow Sneak", "Aqua Jet", "Acid Spray", "Echoed Voice", "Fairy Wind", "Hold Back", "Power-Up Punch", "Vine Whip", "Karate Chop", "Tackle", "Confusion", "Snore", "Poison Fang", "Weather Ball", "Poison Tail", "Payback", "Smack Down", "Flame Charge", "Struggle Bug", "Parabolic Charge", "Draining Kiss", "Vice Grip", "Acrobatics", "Wing Attack", "Bite", "Thief", "Flame Wheel", "Dragon Breath", "Hidden Power", "Ancient Power", "Revenge", "Needle Arm", "Silver Wind", "Covet", "Water Pulse", "Pluck", "Assurance", "Force Palm", "Avalanche", "Bug Bite", "Ominous Wind", "Storm Throw", "Round", "Sky Drop", "Incinerate", "Bulldoze", "Heart Stamp", "Stomp", "Horn Attack", "Psybeam", "Bubble Beam", "Aurora Beam", "Sludge", "Spark", "Knock Off", "Brine", "Chatter", "Venoshock", "Low Sweep", "Hex", "Steamroller", "Mystical Fire", "Headbutt", "Dizzy Punch", "Slash", "Facade", "Smelling Salts", "Secret Power", "Luster Purge", "Mist Ball", "Wake-Up Slap", "U-turn", "Night Slash", "Shadow Claw", "Psycho Cut", "Cross Poison", "Flame Burst", "Chip Away", "Retaliate", "Volt Switch", "Freeze-Dry", "Fire Punch", "Ice Punch", "Thunder Punch", "Giga Drain", "Brick Break", "Signal Beam", "Drain Punch", "Horn Leech", "Relic Song", "Razor Wind", "Drill Peck", "Strength", "Dig", "Waterfall", "Tri Attack", "Crunch", "Extreme Speed", "Shadow Ball", "Dive", "Extrasensory", "Dragon Claw", "Sucker Punch", "Poison Jab", "Dark Pulse", "Seed Bomb", "X-Scissor", "Power Gem", "Flash Cannon", "Discharge", "Lava Plume", "Iron Head", "Psyshock", "Scald", "Water Pledge", "Fire Pledge", "Grass Pledge", "Fiery Dance", "Dazzling Gleam", "Oblivion Wing", "Body Slam", "Dragon Pulse", "Secret Sword", "Flamethrower", "Surf", "Ice Beam", "Thunderbolt", "Psychic", "Sludge Bomb", "Uproar", "Hyper Voice", "Leaf Blade", "Bug Buzz", "Energy Ball", "Earth Power", "Attack Order", "Wild Charge", "Sacred Sword", "Phantom Force", "Petal Blizzard", "Thousand Arrows", "Thousand Waves", "Land's Wrath", "Sludge Wave", "Foul Play", "Moonblast", "Earthquake", "Dream Eater", "Judgment", "Psystrike", "Searing Shot", "Fusion Flare", "Fusion Bolt"
}

function Quest:learningMove(moveName, pokemonIndex)
	return forgetAnyMoveExcept(hmMoves)
end


function Quest:printNpcMap()
	-- find all npc in the map
	range_i_from = 1
	range_i_to = 50
	range_j_from = 1
	range_j_to = 80
	
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

return Quest
