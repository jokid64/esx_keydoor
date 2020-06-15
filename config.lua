Config = {}
Config.Locale = 'fr'

Config.Item = 'green-keycard'  --name of the item needed

Config.Removekey = true --Remove key from inventory once used

Config.DoorList = {

	{
		objName = 'prop_com_ls_door_01',
		objYaw = 135.0,
		objCoords  = vector3(-1145.898, -1991.144, 14.18357),
		textCoords = vector3(-1145.898, -1991.144, 14.18357),
		needJob = false, -- Job is needed with the key ? 
		authorizedJobs = { 'police','sheriff', 'state' },
		locked = true -- Default state is locked or not
	}

}