Config = {}
Config.Locale = 'en'
Config.DoorList = {

	{
		objName = 'prop_com_ls_door_01',
		objYaw = 135.0,
		objCoords  = vector3(-1145.898, -1991.144, 14.18357),
		textCoords = vector3(-1145.898, -1991.144, 14.18357),
		needJob = true, -- Job is needed with the key ? 
		authorizedJobs = { 'police','sheriff', 'state' },
		keyNeeded = 'green-keycard', --The Item needed to open
		removekey = true, -- Remove key from inventory once used
		locked = true -- Default state is locked or not
	},
	
	{
		objName = 'v_ilev_fa_frontdoor',
		objYaw = 178.0,
		objCoords  = vector3(-14.86892, -1441.182, 31.19323),
		textCoords = vector3(-14.46892, -1441.182, 31.19323),
		needJob = false, -- Job is needed with the key ? 
		authorizedJobs = { 'police','sheriff', 'state' },
		keyNeeded = 'magickey', --The Item needed to open
		removekey = false,
		locked = true -- Default state is locked or not
	}

}