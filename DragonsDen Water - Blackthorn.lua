-- Copyright © 2016 Silv3r <silv3r@openmailbox.org>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the LICENSE file for more details.

name = "Leveling: Dragon's Den Water (near Blackthorn)"
author = "Silv3r"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Blackthorn City and the Dragon's Den.
You need a pokémon with surf.]]

alwaysCatch1 = "Dragonair"
alwaysCatch2 = "Bagon"

function onStart()
	levelCap = 101
	shinyCounter = 0
	wildCounter = 0
	startMoney = getMoney()
end

function onPause()
	log("---------------------------------PAUSED - SESSION STATS-------------------------------------")
	log("You have earned ".. tostring(getMoney() - startMoney) .." PokeDollars!")
	log("Shinies Caught: " .. shinyCounter)
	log("Pokemons encountered: " .. wildCounter)
	log("------------------------------------------------------------------------------------------------------")
end

function onResume()
	log("SESSION RESUMED")
end

function onPathAction()
	if not isPokemonUsable(1) or getPokemonLevel(1) >= levelCap then
		if getPokemonLevel(2) < levelCap and isPokemonUsable(2) then
			log("Swapping ".. getPokemonName(1) .." for ".. getPokemonName(2))
			return swapPokemon(1, 2)
		elseif getPokemonLevel(3) < levelCap and isPokemonUsable(3) then
			log("Swapping ".. getPokemonName(1) .." for ".. getPokemonName(3))
			return swapPokemon(1, 3)
		elseif getPokemonLevel(4) < levelCap and isPokemonUsable(4) then
			log("Swapping ".. getPokemonName(1) .." for ".. getPokemonName(4))
			return swapPokemon(1, 4)
		end
	end
	
	if isPokemonUsable(1) then
		if getMapName() == "Pokecenter Blackthorn" then
			moveToMap("Blackthorn City")
		elseif getMapName() == "Blackthorn City" then
			moveToMap("Dragons Den Entrance")
		elseif getMapName() == "Dragons Den Entrance" then
			moveToMap("Dragons Den")
		elseif getMapName() == "Dragons Den" then
			moveToWater()
		end
	else
		if getMapName() == "Dragons Den" then
			moveToMap("Dragons Den Entrance")
		elseif getMapName() == "Dragons Den Entrance" then
			moveToMap("Blackthorn City")
		elseif getMapName() == "Blackthorn City" then
			moveToMap("Pokecenter Blackthorn")
		elseif getMapName() == "Pokecenter Blackthorn" then
			usePokecenter()
		end
	end
end

function onBattleAction()
	if isWildBattle() and isOpponentShiny() or getOpponentName() == alwaysCatch1 or getOpponentName() == alwaysCatch2 then
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return
		end
	end
	if getActivePokemonNumber() == 1 then
		return attack() or sendUsablePokemon() or run() or sendAnyPokemon()
	else
		return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
	end
end
