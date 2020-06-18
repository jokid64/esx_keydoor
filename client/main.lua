ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	-- Update the door list
	ESX.TriggerServerCallback('esx_keydoor:getDoorInfo', function(doorInfo)
		for doorID,state in pairs(doorInfo) do
			Config.DoorList[doorID].locked = state
		end
	end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Get objects every second, instead of every frame
Citizen.CreateThread(function()
	while true do
		for _,doorID in ipairs(Config.DoorList) do
			if doorID.doors then
				for k,v in ipairs(doorID.doors) do
					if not v.object or not DoesEntityExist(v.object) then
						v.object = GetClosestObjectOfType(v.objCoords, 1.0, GetHashKey(v.objName), false, false, false)
					end
				end
			else
				if not doorID.object or not DoesEntityExist(doorID.object) then
					doorID.object = GetClosestObjectOfType(doorID.objCoords, 1.0, GetHashKey(doorID.objName), false, false, false)
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local playerCoords = GetEntityCoords(PlayerPedId())

		for k,doorID in ipairs(Config.DoorList) do
			local distance

			if doorID.doors then
				distance = #(playerCoords - doorID.doors[1].objCoords)
			else
				distance = #(playerCoords - doorID.objCoords)
			end

			local isAuthorized = IsAuthorized(doorID)
			local maxDistance, size, displayText = 10, 1, _U('unlocked')

			if doorID.distance then
				maxDistance = doorID.distance
			end

			if distance < 50 then
				if doorID.doors then
					for _,v in ipairs(doorID.doors) do
						FreezeEntityPosition(v.object, doorID.locked)

						if doorID.locked and v.objYaw and GetEntityRotation(v.object).z ~= v.objYaw then
							SetEntityRotation(v.object, 0.0, 0.0, v.objYaw, 2, true)
						end
					end
				else
					FreezeEntityPosition(doorID.object, doorID.locked)

					if doorID.locked and doorID.objYaw and GetEntityRotation(doorID.object).z ~= doorID.objYaw then
						SetEntityRotation(doorID.object, 0.0, 0.0, doorID.objYaw, 2, true)
					end
				end
			end

			if distance < maxDistance then
				if doorID.size then
					size = doorID.size
				end

				if doorID.locked then
					displayText = _U('locked')
				end
				if not doorID.locked then
					displayText = _U('unlocked')
				end

				if isAuthorized and doorID.locked then
					displayText = _U('alocked')
				end

				if isAuthorized and not doorID.locked then
					displayText = _U('aunlocked')
				end

				ESX.Game.Utils.DrawText3D(doorID.textCoords, displayText, size)

				if IsControlJustReleased(0, 38) then
					if isAuthorized then
							local inventory = ESX.GetPlayerData().inventory
							local count = 0
							
								for i=1, #inventory, 1 do
								local itemname = doorID.keyNeeded
									if inventory[i].name == itemname then
										count = inventory[i].count
										name = inventory[i].name
									end
								end
								
								if count > 0 then
										doorID.locked = not doorID.locked
										TriggerServerEvent('esx_keydoor:updateState', k, doorID.locked) -- Broadcast new state of the door to everyone
									if doorID.removekey then
										TriggerServerEvent('esx_keydoor:removekey', name, 1)
									end
								else
									ESX.ShowNotification(_U('nokey'))
								end

					end
				end
			end
		end
	end
end)

function IsAuthorized(doorID)

	if doorID.needJob then
		for _,job in pairs(doorID.authorizedJobs) do
			if job == ESX.PlayerData.job.name then
				return true
			end
		end
	else
	return true
	end
end

-- Set state for a door
RegisterNetEvent('esx_keydoor:setState')
AddEventHandler('esx_keydoor:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)