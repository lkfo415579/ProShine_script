name = "Universal ExpShare"
author = "imMigno"

description = [[
This script will automaticly level the weakest Pokemon on your Team with your strongest
and checks if booth of them are usable ! ]]

function onStart()
	
	-- Load Configurations
	dofile "config.lua"

	log(" ")
	log("=========== WELCOME | START ============")
	log("Welcome to the Universal ExpSharing by imMigno")
	log("Version 2.0.7 | Updated: 08-30-2016 | 03.05 AM")
	log("====================================")
	log(" ")

	path = 0
	trapped = false

	if Map1 ~= "" then
		path = path + 1
	end
	if Map2 ~= "" then
		path = path + 1
	end
	if Map3 ~= "" then
		path = path + 1
	end
	if Map4 ~= "" then
		path = path + 1
	end
	if Map5 ~= "" then
		path = path + 1
	end
end

-- Config -> LevelSpot
function getLevelSpot()
	if LevelSpot == "Grass" then
		moveToGrass()
	elseif LevelSpot == "Water" then
		moveToWater()
	elseif LevelSpot == "Rectangle" then
		moveToRectangle(minX, minY, maxX, maxY)
	end
end

-- Shortcut -> GoToPokecenter
function healPokemon()
	if path == 0 and City == "" and Pokecenter == LevelLocation then
		if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
			log("ExpShare | Using ".. Mount)
			useItem(Mount)
		elseif isMounted() then
			getHealed()
		else
			getHealed()
		end
	elseif path == 0 then
		if getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(City)
			else
				moveToMap(City)
			end
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Pokecenter)
			else
				moveToMap(Pokecenter)
			end
		elseif getMapName() == Pokecenter then
			getHealed()
		end
	elseif path == 1 then
		if getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map1)
			else
				moveToMap(Map1)
			end
		elseif getMapName() == Map1 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(City)
			else
				moveToMap(City)
			end
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Pokecenter)
			else
				moveToMap(Pokecenter)
			end
		elseif getMapName() == Pokecenter then
			getHealed()
		end
	elseif path == 2 then
		if getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map2)
			else
				moveToMap(Map2)
			end
		elseif getMapName() == Map2 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map1)
			else
				moveToMap(Map1)
			end
		elseif getMapName() == Map1 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(City)
			else
				moveToMap(City)
			end
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Pokecenter)
			else
				moveToMap(Pokecenter)
			end
		elseif getMapName() == Pokecenter then
			getHealed()
		end
	elseif path == 3 then
		if getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map3)
			else
				moveToMap(Map3)
			end
		elseif getMapName() == Map3 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map2)
			else
				moveToMap(Map2)
			end
		elseif getMapName() == Map2 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map1)
			else
				moveToMap(Map1)
			end
		elseif getMapName() == Map1 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(City)
			else
				moveToMap(City)
			end
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Pokecenter)
			else
				moveToMap(Pokecenter)
			end
		elseif getMapName() == Pokecenter then
			getHealed()
		end
	elseif path == 4 then
		if getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map4)
			else
				moveToMap(Map4)
			end
		elseif getMapName() == Map4 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map3)
			else
				moveToMap(Map3)
			end
		elseif getMapName() == Map3 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map2)
			else
				moveToMap(Map2)
			end
		elseif getMapName() == Map2 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map1)
			else
				moveToMap(Map1)
			end
		elseif getMapName() == Map1 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(City)
			else
				moveToMap(City)
			end
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Pokecenter)
			else
				moveToMap(Pokecenter)
			end
		elseif getMapName() == Pokecenter then
			getHealed()
		end
	elseif path == 5 then
		if getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map5)
			else
				moveToMap(Map5)
			end
		elseif getMapName() == Map5 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map4)
			else
				moveToMap(Map4)
			end
		elseif getMapName() == Map4 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map3)
			else
				moveToMap(Map3)
			end
		elseif getMapName() == Map3 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map2)
			else
				moveToMap(Map2)
			end
		elseif getMapName() == Map2 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map1)
			else
				moveToMap(Map1)
			end
		elseif getMapName() == Map1 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(City)
			else
				moveToMap(City)
			end
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Pokecenter)
			else
				moveToMap(Pokecenter)
			end
		elseif getMapName() == Pokecenter then
			getHealed()
		end
	end
end

-- Shortcut -> GoToLevelLocation
function moveToDestination()
	-- walk to Destination
	-- No City & LevelLocation == Pokecenter
	if path == 0 and City == "" and Pokecenter == LevelLocation then
		if getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using".. Mount)
				useItem(Mount)
			elseif isMounted() then
				getLevelSpot()
			else
				getLevelSpot()
			end
		else
			getHealed()
		end

	-- Path of no City between Pokecenter and LevelSpot
	elseif path == 0 and City == "" then
		if getMapName() == Pokecenter then
			moveToMap(LevelLocation)
		elseif getMapName() == LevelLocation then
			getLevelSpot()
		end
	-- Path of 0 Maps between City and LevelSpot
	elseif path == 0 then
		if getMapName() == Pokecenter then
			moveToMap(City)
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(LevelLocation)
			else
				moveToMap(LevelLocation)
			end
		elseif getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				getLevelSpot()
			else
				getLevelSpot()
			end
		end
	-- Path of 1 Maps between City and LevelSpot	
	elseif path == 1 then
		if getMapName() == Pokecenter then
			moveToMap(City)
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map1)
			else
				moveToMap(Map1)
			end
		elseif getMapName() == Map1 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(LevelLocation)
			else
				moveToMap(LevelLocation)
			end
		elseif getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				getLevelSpot()
			else
				getLevelSpot()
			end
		end
	-- Path of 2 Maps between City and LevelSpot	
	elseif path == 2 then
		if getMapName() == Pokecenter then
			moveToMap(City)
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map1)
			else
				moveToMap(Map1)
			end
		elseif getMapName() == Map1 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map2)
			else
				moveToMap(Map2)
			end
		elseif getMapName() == Map2 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(LevelLocation)
			else
				moveToMap(LevelLocation)
			end
		elseif getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				getLevelSpot()
			else
				getLevelSpot()
			end
		end
	-- Path of 3 Maps between City and LevelSpot	
	elseif path == 3 then
		if getMapName() == Pokecenter then
			moveToMap(City)
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map1)
			else
				moveToMap(Map1)
			end
		elseif getMapName() == Map1 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map2)
			else
				moveToMap(Map2)
			end
		elseif getMapName() == Map2 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map3)
			else
				moveToMap(Map3)
			end
		elseif getMapName() == Map3 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(LevelLocation)
			else
				moveToMap(LevelLocation)
			end
		elseif getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				getLevelSpot()
			else
				getLevelSpot()
			end
		end
	-- Path of 4 Maps between City and LevelSpot	
	elseif path == 4 then
		if getMapName() == Pokecenter then
			moveToMap(City)
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map1)
			else
				moveToMap(Map1)
			end
		elseif getMapName() == Map1 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map2)
			else
				moveToMap(Map2)
			end
		elseif getMapName() == Map2 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map3)
			else
				moveToMap(Map3)
			end
		elseif getMapName() == Map3 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map4)
			else
				moveToMap(Map4)
			end
		elseif getMapName() == Map4 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(LevelLocation)
			else
				moveToMap(LevelLocation)
			end
		elseif getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				getLevelSpot()
			else
				getLevelSpot()
			end
		end
	-- Path of 5 Maps between City and LevelSpot	
	elseif path == 5 then
		if getMapName() == Pokecenter then
			moveToMap(City)
		elseif getMapName() == City then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map1)
			else
				moveToMap(Map1)
			end
		elseif getMapName() == Map1 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map2)
			else
				moveToMap(Map2)
			end
		elseif getMapName() == Map2 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map3)
			else
				moveToMap(Map3)
			end
		elseif getMapName() == Map3 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map4)
			else
				moveToMap(Map4)
			end
		elseif getMapName() == Map4 then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				moveToMap(Map5)
			else
				moveToMap(Map5)
			end
		elseif getMapName() == Map5 then
			moveToMap(LevelLocation)
		elseif getMapName() == LevelLocation then
			if hasItem(Mount) and not isMounted() and isOutside() and not isSurfing() then
				log("ExpShare | Using ".. Mount)
				useItem(Mount)
			elseif isMounted() then
				getLevelSpot()
			else
				getLevelSpot()
			end
		end
	end
end

function getHealed()
	if getMapName() == "Indigo Plateau Center" then
		talkToNpcOnCell(4, 22)

	elseif getMapName() == "Seafoam B4F" then
		pushDialogAnswer(1)
		pushDialogAnswer(1)
        talkToNpcOnCell(59, 13)

	else
		usePokecenter()
	end
end

function onPathAction()

	trapped = false

	if getTeamSize() == 2 then
		if isPokemonUsable(1) and isPokemonUsable(2) and getPokemonHealthPercent(2) >= 15 then
			if isTeamRangeSortedByLevelAscending(1, 2) then
				if getPokemonLevel(1) >= StopLevel and getPokemonLevel(2) >= StopLevel then
					log(" ")
					log("============ FINISHED LEVELING ============")
					log("The StopLevel has been reached, Bot stopped")
					log("===========================================")
					fatal(" ")
				else
					moveToDestination()
				end
			else
				return sortTeamRangeByLevelAscending(1, 2)
			end
		else
			healPokemon()
		end

	elseif getTeamSize() == 3 then
		if isPokemonUsable(1) and isPokemonUsable(2) and isPokemonUsable(3) and getPokemonHealthPercent(3) >= 15 then
			if isTeamRangeSortedByLevelAscending(1, 3) then
				if getPokemonLevel(1) >= StopLevel and getPokemonLevel(2) >= StopLevel and getPokemonLevel(3) >= StopLevel then
					log(" ")
					log("============ FINISHED LEVELING ============")
					log("The StopLevel has been reached, Bot stopped")
					log("===========================================")
					fatal(" ")
				else
					moveToDestination()
				end
			else
				return sortTeamRangeByLevelAscending(1, 3)
			end
		else
			healPokemon()
		end

	elseif getTeamSize() == 4 then
		if isPokemonUsable(1) and isPokemonUsable(2) and isPokemonUsable(3) and isPokemonUsable(4) and getPokemonHealthPercent(4) >= 15 then
			if isTeamRangeSortedByLevelAscending(1, 4) then
				if getPokemonLevel(1) >= StopLevel and getPokemonLevel(2) >= StopLevel and getPokemonLevel(3) >= StopLevel and getPokemonLevel(4) >= StopLevel then
					log(" ")
					log("============ FINISHED LEVELING ============")
					log("The StopLevel has been reached, Bot stopped")
					log("===========================================")
					fatal(" ")
				else
					moveToDestination()
				end
			else
				return sortTeamRangeByLevelAscending(1, 4)
			end
		else
			healPokemon()
		end

	elseif getTeamSize() == 5 then
		if isPokemonUsable(1) and isPokemonUsable(2) and isPokemonUsable(3) and isPokemonUsable(4) and isPokemonUsable(5) and getPokemonHealthPercent(5) >= 15 then
		 	if isTeamRangeSortedByLevelAscending(1, 5) then
		 		if getPokemonLevel(1) >= StopLevel and getPokemonLevel(2) >= StopLevel and getPokemonLevel(3) >= StopLevel and getPokemonLevel(4) >= StopLevel and getPokemonLevel(5) >= StopLevel then
					log(" ")
					log("============ FINISHED LEVELING ============")
					log("The StopLevel has been reached, Bot stopped")
					log("===========================================")
					fatal(" ")
				else
					moveToDestination()
				end
		 	else
		 		return sortTeamRangeByLevelAscending(1, 5)
		 	end
		 else
			healPokemon()
		end

	elseif getTeamSize() == 6 then
		if isPokemonUsable(1) and isPokemonUsable(2) and isPokemonUsable(3) and isPokemonUsable(4) and isPokemonUsable(5) and isPokemonUsable(6) and getPokemonHealthPercent(6) >= 15 then
			if isTeamRangeSortedByLevelAscending(1, 6) then
				if getPokemonLevel(1) >= StopLevel and getPokemonLevel(2) >= StopLevel and getPokemonLevel(3) >= StopLevel and getPokemonLevel(4) >= StopLevel and getPokemonLevel(5) >= StopLevel and getPokemonLevel(6) >= StopLevel then
					log(" ")
					log("============ FINISHED LEVELING ============")
					log("The StopLevel has been reached, Bot stopped")
					log("===========================================")
					fatal(" ")
				else
					moveToDestination()
				end
			else
				return sortTeamRangeByLevelAscending(1, 6)
			end
		else
			healPokemon()
		end

	else
		log(" ")
		log("=========== FATAL ERROR LOG ===========")
		log("You need atleast 2 Pokemon in your Team")
		log("        - ExpSharing destoyed -        ")
		log("=======================================")
		fatal(" ")
	end
end

function onBattleAction()
	-- Shiny support
	if isWildBattle() and isOpponentShiny() then
		if getUsablePokemonCount() == 2 and getPokemonHealthPercent(2) >= 15 then
			if getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 2) and getPokemonHealthPercent(2) >= 15 and getPokemonLevel(1) >= SwapCap then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") or attack() or run() or sendUsablePokemon() then
					return
				end
			elseif getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 2) and getPokemonHealthPercent(2) >= 15 and getPokemonLevel(1) < SwapCap then
				sendPokemon(2)
			elseif getActivePokemonNumber() == 2 and isTeamRangeSortedByLevelAscending(1, 2) and getPokemonHealthPercent(2) >= 15 then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") or attack() or run() or sendUsablePokemon() then
					return
				end
			end

		elseif getUsablePokemonCount() == 3 and getPokemonHealthPercent(3) >= 15 then
			if getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 3) and getPokemonHealthPercent(3) >= 15 and getPokemonLevel(1) >= SwapCap then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") or attack() or run() or sendUsablePokemon() then
					return
				end
			elseif getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 3) and getPokemonHealthPercent(3) >= 15 and getPokemonLevel(1) < SwapCap then
				sendPokemon(3)
			elseif getActivePokemonNumber() == 3 and isTeamRangeSortedByLevelAscending(1, 3) and getPokemonHealthPercent(3) >= 15 then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") or attack() or run() or sendUsablePokemon() then
					return
				end
			end
		elseif getUsablePokemonCount() == 4 and getPokemonHealthPercent(4) >= 15 then
			if getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 4) and getPokemonHealthPercent(4) >= 15 and getPokemonLevel(1) >= SwapCap then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") or attack() or run() or sendUsablePokemon() then
					return
				end
			elseif getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 4) and getPokemonHealthPercent(4) >= 15 and getPokemonLevel(1) < SwapCap then
				sendPokemon(2)
			elseif getActivePokemonNumber() == 4 and isTeamRangeSortedByLevelAscending(1, 4) and getPokemonHealthPercent(4) >= 15 then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") or attack() or run() or sendUsablePokemon() then
					return
				end
			end
		elseif getUsablePokemonCount() == 5 and getPokemonHealthPercent(5) >= 15 then
			if getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 5) and getPokemonHealthPercent(5) >= 15 and getPokemonLevel(1) >= SwapCap then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") or attack() or run() or sendUsablePokemon() then
					return
				end
			elseif getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 5) and getPokemonHealthPercent(5) >= 15 and getPokemonLevel(1) < SwapCap then
				sendPokemon(2)
			elseif getActivePokemonNumber() == 5 and isTeamRangeSortedByLevelAscending(1, 5) and getPokemonHealthPercent(5) >= 15 then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") or attack() or run() or sendUsablePokemon() then
					return
				end
			end
		elseif getUsablePokemonCount() == 6 and getPokemonHealthPercent(6) >= 15 then
			if getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 6) and getPokemonHealthPercent(6) >= 15 and getPokemonLevel(1) >= SwapCap then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") or attack() or run() or sendUsablePokemon() then
					return
				end
			elseif getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 6) and getPokemonHealthPercent(6) >= 15 and getPokemonLevel(1) < SwapCap then
				sendPokemon(6)
			elseif getActivePokemonNumber() == 6 and isTeamRangeSortedByLevelAscending(1, 6) and getPokemonHealthPercent(6) >= 15 then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") or attack() or run() or sendUsablePokemon() then
					return
				end
			end
		end
	
	elseif isWildBattle() and not isOpponentShiny() then
		-- Battle Action
		-- 2 Pokemon Usable
		if getUsablePokemonCount() == 2 and getPokemonHealthPercent(2) >= 15 then
			if getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 2) and getPokemonHealthPercent(2) >= 15 and getPokemonLevel(1) >= SwapCap then
				if trapped == true then
					return attack() or sendUsablePokemon()
				else
					return attack() or sendUsablePokemon() or sendAnyPokemon() or run()
				end
			elseif getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 2) and getPokemonHealthPercent(2) >= 15 and getPokemonLevel(1) < SwapCap then
				if trapped == true then
					return attack or sendUsablePokemon()
				else
					sendPokemon(2)
					log(" ")
					log("Your ".. getPokemonName(1) .. " has been switched with ".. getPokemonName(2))
					log(" ")
				end
			elseif getActivePokemonNumber() == 2 and isTeamRangeSortedByLevelAscending(1, 2) and getPokemonHealthPercent(2) >= 15 then
				return attack() or run() or sendUsablePokemon() or sendAnyPokemon()
			else
				if trapped == true then
					return attack() or sendUsablePokemon()
				else
					return run() or sendUsablePokemon() or sendAnyPokemon() or attack()
				end
			end
			
		-- 3 Pokemon Usable
		elseif getUsablePokemonCount() == 3 and getPokemonHealthPercent(3) >= 15 then
			if getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 3) and getPokemonHealthPercent(2) >= 15 and getPokemonLevel(1) >= SwapCap then
				if trapped == true then
					return attack() or sendUsablePokemon()
				else
					return attack() or sendUsablePokemon() or sendAnyPokemon() or run()
				end
			elseif getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 3) and getPokemonHealthPercent(3) >= 15 and getPokemonLevel(1) < SwapCap then
				if trapped == true then
					return attack or sendUsablePokemon()
				else
					sendPokemon(3)
					log(" ")
					log("Your ".. getPokemonName(1) .. " has been switched with ".. getPokemonName(3))
					log(" ")
				end
			elseif getActivePokemonNumber() == 3 and isTeamRangeSortedByLevelAscending(1, 3) and getPokemonHealthPercent(3) >= 15 then
				return attack() or run() or sendUsablePokemon() or sendAnyPokemon()
			else
				if trapped == true then
					return attack() or sendUsablePokemon()
				else
					return run() or sendUsablePokemon() or sendAnyPokemon() or attack()
				end
			end

		-- 4 Pokemon Usable
		elseif getUsablePokemonCount() == 4 and getPokemonHealthPercent(4) >= 15 then
			if getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 4) and getPokemonHealthPercent(2) >= 15 and getPokemonLevel(1) >= SwapCap then
				if trapped == true then
					return attack() or sendUsablePokemon()
				else
					return attack() or sendUsablePokemon() or sendAnyPokemon() or run()
				end
			elseif getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 4) and getPokemonHealthPercent(4) >= 15 and getPokemonLevel(1) < SwapCap then
				if trapped == true then
					return attack or sendUsablePokemon()
				else
					sendPokemon(4)
					log(" ")
					log("Your ".. getPokemonName(1) .. " has been switched with ".. getPokemonName(4))
					log(" ")
				end
			elseif getActivePokemonNumber() == 4 and isTeamRangeSortedByLevelAscending(1, 4) and getPokemonHealthPercent(4) >= 15 then
				return attack() or run() or sendUsablePokemon() or sendAnyPokemon()
			else
				if trapped == true then
					return attack() or sendUsablePokemon()
				else
					return run() or sendUsablePokemon() or sendAnyPokemon() or attack()
				end
			end

		-- 5 Pokemon Usable
		elseif getUsablePokemonCount() == 5 and getPokemonHealthPercent(5) >= 15 then
			if getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 5) and getPokemonHealthPercent(2) >= 15 and getPokemonLevel(1) >= SwapCap then
				if trapped == true then
					return attack() or sendUsablePokemon()
				else
					return attack() or sendUsablePokemon() or sendAnyPokemon() or run()
				end
			elseif getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 5) and getPokemonHealthPercent(5) >= 15 and getPokemonLevel(1) < SwapCap then
				if trapped == true then
					return attack or sendUsablePokemon()
				else
					sendPokemon(5)
					log(" ")
					log("Your ".. getPokemonName(1) .. " has been switched with ".. getPokemonName(5))
					log(" ")
				end
			elseif getActivePokemonNumber() == 5 and isTeamRangeSortedByLevelAscending(1, 5) and getPokemonHealthPercent(5) >= 15 then
				return attack() or run() or sendUsablePokemon() or sendAnyPokemon()
			else
				if trapped == true then
					return attack() or sendUsablePokemon()
				else
					return run() or sendUsablePokemon() or sendAnyPokemon() or attack()
				end
			end

		-- 6 Pokemon usable
		elseif getUsablePokemonCount() == 6 and getPokemonHealthPercent(6) >= 15 then
			if getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 6) and getPokemonHealthPercent(6) >= 15 and getPokemonLevel(1) >= SwapCap then
				if trapped == true then
					return attack() or sendUsablePokemon()
				else
					return attack() or sendUsablePokemon() or sendAnyPokemon() or run()
				end
			elseif getActivePokemonNumber() == 1 and isTeamRangeSortedByLevelAscending(1, 6) and getPokemonHealthPercent(6) >= 15 and getPokemonLevel(1) < SwapCap then
				if trapped == true then
					return attack or sendUsablePokemon()
				else
					sendPokemon(6)
					log(" ")
					log("Your ".. getPokemonName(1) .. " has been switched with ".. getPokemonName(6))
					log(" ")
				end
			elseif getActivePokemonNumber() == 6 and isTeamRangeSortedByLevelAscending(1, 6) and getPokemonHealthPercent(6) >= 15 then
				return attack() or run() or sendUsablePokemon() or sendAnyPokemon()
			else
				if trapped == true then
					return attack() or sendUsablePokemon()
				else
					return run() or sendUsablePokemon() or sendAnyPokemon() or attack()
				end
			end
		else
			if trapped == true then
				return attack() or sendUsablePokemon()
			else
				return run() or sendUsablePokemon() or sendAnyPokemon() or attack()
			end
		end
	end
end

function onBattleMessage(wild)
	if stringContains(wild, "wrapped") or stringContains(wild, "You can not switch this Pokemon") or stringContains(wild, "You failed to run away") or stringContains(wild, "You can not run away") then
		trapped = true
	end		
end

function onLearningMove(moveName, pokemonIndex)
    local ForgetMoveName
    local ForgetMoveTP = 9999
    for moveId=1, 4, 1 do
        local MoveName = getPokemonMoveName(pokemonIndex, moveId)
        if MoveName == nil or MoveName == "cut" or MoveName == "surf" or MoveName == "rock smash" or MoveName == "rocksmash" then
        else
        local CalcMoveTP = math.modf((getPokemonMaxPowerPoints(pokemonIndex,moveId) * getPokemonMovePower(pokemonIndex,moveId))*(math.abs(getPokemonMoveAccuracy(pokemonIndex,moveId)) / 100))
            if CalcMoveTP < ForgetMoveTP then
                ForgetMoveTP = CalcMoveTP
                ForgetMoveName = MoveName
            end
        end
    end
    log("==== Learning new Move ====")
    log(" ")
    log("[Learned] ".. moveName)
    log("[Forgot ] ".. ForgetMoveName)
    log(" ")
    log("===========================")
    return ForgetMoveName
end