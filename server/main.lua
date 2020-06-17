ESX = nil
local doorInfo = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_keydoor:updateState')
AddEventHandler('esx_keydoor:updateState', function(doorID, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(doorID) ~= 'number' then
		print(('esx_keydoor: %s didn\'t send a number!'):format(xPlayer.identifier))
		return
	end

	if type(state) ~= 'boolean' then
		print(('esx_keydoor: %s attempted to update invalid state!'):format(xPlayer.identifier))
		return
	end

	if not Config.DoorList[doorID] then
		print(('esx_keydoor: %s attempted to update invalid door!'):format(xPlayer.identifier))
		return
	end

	if not IsAuthorized(xPlayer.job.name, Config.DoorList[doorID]) then
		print(('esx_keydoor: %s was not authorized to open a locked door!'):format(xPlayer.identifier))
		return
	end

	doorInfo[doorID] = state

	TriggerClientEvent('esx_keydoor:setState', -1, doorID, state)
end)

ESX.RegisterServerCallback('esx_keydoor:getDoorInfo', function(source, cb)
	cb(doorInfo)
end)

RegisterServerEvent('esx_keydoor:removekey')
AddEventHandler('esx_keydoor:removekey', function(item, amount)
local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.removeInventoryItem(item, amount)
end)

function IsAuthorized(jobName, doorID)
	if doorID.needJob then
		for _,job in pairs(doorID.authorizedJobs) do
			if job == jobName then
				return true
			end
		end
	else
	return true
	end
end