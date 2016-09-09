name = "Victory Road Kanto 3F leveler"
author = "LKfo"
description = [[Levelling first 4 pokemon in Victory Road with Shiny Pokemon detection! - with mount]]
local game   = require "Libs/gamelib"

function onStart()
	levelCap = 102
	shinyCounter = 0
	wildCounter = 0
	startMoney = getMoney()
    kill = 0
    OnPoint = false
    Healing = true
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

function onBattleMessage(wild)
	if stringContains(wild, "A Wild SHINY ") then
		shinyCounter = shinyCounter + 1
		wildCounter = wildCounter + 1
	elseif stringContains(wild, "A Wild ") then
		wildCounter = wildCounter + 1
	end
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
		elseif getPokemonLevel(1) >= levelCap and getPokemonLevel(2) >= levelCap and getPokemonLevel(3) >= levelCap and getPokemonLevel(4) >= levelCap then
			fatal("All 4 pokemon have been trained to the desired level!")
		else
            --need healing
            Healing = true
            if getMapName() == "Victory Road Kanto 2F" then
				moveToMap("Victory Road Kanto 3F")
			elseif getMapName() == "Victory Road Kanto 3F" then
				log("Moving to Indigo Plateau...")
				moveToMap("Indigo Plateau")
			elseif getMapName() == "Indigo Plateau" then
				log("Moving to Indigo Plateau Center...")
				moveToMap("Indigo Plateau Center")
			elseif getMapName() == "Indigo Plateau Center" then
				log("Arrived at Indigo Plateau Center!")
				pushDialogAnswer(1)
				talkToNpcOnCell(4,22)
			end
		end
	end

	if isPokemonUsable(1) and getPokemonLevel(1) < levelCap then
		if getMapName() == "Indigo Plateau Center" then
			log("Moving to Indigo Plateau...")
			moveToMap("Indigo Plateau")
		elseif getMapName() == "Indigo Plateau" then
			log("Moving to Victory Road...")
			moveToMap("Victory Road Kanto 3F")
            if OnPoint and not Healing then
                fatal("Got transport to on9 place stop bot!")
            end
		elseif getMapName() == "Victory Road Kanto 3F" then
			--moveToRectangle(46, 14, 47, 22
            moveToCell(29,17)
            if OnPoint and not Healing then
                fatal("Got transport to on9 place stop bot!")
            end
		elseif getMapName() == "Victory Road Kanto 2F" then
            if kill < 200 then
                --log("kill less than 200")
                moveToRectangle(12, 14, 14, 18)
            elseif kill > 400 then
                log("Reset kill")
                kill = 0
                Healing = true
            else
                moveToRectangle(14, 23, 16, 26)
            end

            if game.inRectangle(12, 14, 14, 18) or game.inRectangle(14, 23, 16, 26) then
                OnPoint = true
                Healing = false
            elseif Healing then
                OnPoint = false
            elseif OnPoint and not Healing then
                fatal("Got transport to on9 place stop bot!")
            end

        else
            --god damn GM
            fatal("Got transport to on9 place stop bot!")
		end
	end
end

function onBattleAction()
	if isWildBattle() and isOpponentShiny() then 
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return
		end
	end
	--if getActivePokemonNumber() >= 1 and (isOpponentEffortValue("Speed") or isOpponentEffortValue("Attack")) then
	if getActivePokemonNumber() >= 1 then
        kill = kill + 1
		return attack() or sendUsablePokemon() or run() or sendAnyPokemon()
	else
		return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
	end
end