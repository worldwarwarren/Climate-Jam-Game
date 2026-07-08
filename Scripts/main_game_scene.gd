extends Node2D

#Lists all of the microgames available
var microgames = [
	preload("res://Scenes/Microgames/PressButton.tscn"),
	preload("res://Scenes/Microgames/BluePressButton.tscn")
]
#Checks the last microgame that has been played
#Used later to prevent repeats
var last_microgame = null

func _ready():
	game_loop()
	
	
#Function to loop the microgames
func game_loop():
	while true:
		await play_microgame()

#Function to play a microgame
func play_microgame():
	#Chooses a random microgame from the microgames list
	var microgame_scene = microgames.pick_random()
	#Checks if the microgame was the last one played
	while microgame_scene == last_microgame:
		microgame_scene = microgames.pick_random()
	#Sets the current game as the new "last_microgame"
	last_microgame = microgame_scene
	
	#Instantiates the microgame, adds it as a child, and centers it.
	var microgame = microgame_scene.instantiate()
	add_child(microgame)
	#Position line could be replaced if container is used later on
	microgame.position = Vector2(576, 324)
	
	#Sets the difficulty/speed. Does nothing right now.
	microgame.start(1.0)
	#Times the game
	await get_tree().create_timer(3.0).timeout
	
	#Checks if the game was won and then deletes the instance
	if microgame.did_win:
		print("WIN")
	else:
		print("LOSE")
	microgame.queue_free()
