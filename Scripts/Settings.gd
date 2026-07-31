extends Node

const SET_PATH = "user://settings.json"

# Volume settings, keeps track of audio levels for the audio buses (linear, not db)
var VolumeSettings = {"Master":1,"SFX":1,"Music":1}


func _saveSettings():
	# Saves new volumes
	VolumeSettings["Master"] = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master"))
	VolumeSettings["SFX"] = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("SFX"))
	VolumeSettings["Music"] = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Music"))
	# Uses the FileAccess class to open the JSON file for writing operations
	var file = FileAccess.open(SET_PATH, FileAccess.WRITE)
	# Stringifies the volume settings array so the JSON file can store it
	var data = JSON.stringify(VolumeSettings)
	# Stores the data
	file.store_string(data)
	# Closes the file so it won't get more edits
	file.close()

func _loadSettings():
	# Returns if it can't access the JSON file
	if not FileAccess.file_exists(SET_PATH):
		return
	# Uses the FileAccess class to open the JSON file for reading operations
	var file = FileAccess.open(SET_PATH, FileAccess.READ)
	# Reads the file and stores it in a variable
	var scoreData = file.get_as_text()
	# Closes the file so it won't get more edits
	file.close()
	# Makes a JSON object to parse the data
	var json = JSON.new()
	# A parse variable, returns OK if the parse is successful
	var error = json.parse(scoreData)
	# If the parse works
	if error == OK:
		# Replaces the base volume settings with the stuff in the JSON file
		VolumeSettings = json.data
		#print(VolumeSettings)
		# Set all the buses to the given values
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(VolumeSettings["Master"]))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(VolumeSettings["SFX"]))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(VolumeSettings["Music"]))
	# If it doesn't work
	else:
		return
