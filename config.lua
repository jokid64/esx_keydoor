Config = {}
Config.Locale = 'fr'

Config.Removekey = true --Remove key from inventory once used
Config.Item = 'green-keycard'
Config.DoorList = {

	{
		objName = 'prop_com_ls_door_01',
		objYaw = 135.0,
		objCoords  = vector3(-1145.898, -1991.144, 14.18357),
		textCoords = vector3(-1145.898, -1991.144, 14.18357),
		needJob = true, -- Job is needed with the key ? 
		authorizedJobs = { 'police','sheriff', 'state', 'green-keycard' },
		keyNeeded = { 'green-keycard' }, --The Item needed to open
		locked = true -- Default state is locked or not
	}

}