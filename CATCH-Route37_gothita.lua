-- Copyright © 2016 Silv3r <silv3r@openmailbox.org>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the LICENSE file for more details.

name = "Speed ATK EV: Route 37"
author = "Lkfo"
description = [[......]]

killed = 0
swaping = 1
alwaysCatch1 = "Gothita"


function onPause()
	log("killed:"..killed)
	log("swaping:"..swaping)
end

function onPathAction()
	if killed > 500 then
		swaping = swaping + 1
		if swaping > 6 then
			swaping = 2
		end
		killed = 0
		log("Swapping ".. getPokemonName(1) .." for ".. getPokemonName(swaping))
		return swapPokemon(1, swaping)
	end
	if isPokemonUsable(1) then
		if getMapName() == "Pokecenter Ecruteak" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Ecruteak City" then
			moveToMap("Route 37")
		elseif getMapName() == "Route 37" then
			if not isMounted() then
				--useItem("Arcanine Mount")
				useItem("S Ninetales Mount")
			else
				moveToRectangle(15, 9, 19, 11)
			end
		end
	else
		if getMapName() == "Route 37" then
			moveToMap("Ecruteak City")
		elseif getMapName() == "Ecruteak City" then
			moveToMap("Pokecenter Ecruteak")
		elseif getMapName() == "Pokecenter Ecruteak" then
			usePokecenter()
		end
	end
end

function onBattleAction()
	if isWildBattle() and isOpponentShiny() or getOpponentName() == alwaysCatch1  then
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return
		end
	end
	if getActivePokemonNumber() == 1 and (isOpponentEffortValue("Speed") or isOpponentEffortValue("Attack")) then
		---killed = killed + 1
		return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
	else
		return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
	end
end
