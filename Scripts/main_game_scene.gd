extends Node2D

@onready var Transition = $Transition
#Lists all of the microgames available
var microgames = [
	preload("res://Scenes/Microgames/PressButton.tscn"),
	preload("res://Scenes/Microgames/BluePressButton.tscn")
]
#Checks the last microgame that has been played
#Used later to prevent repeats
var last_microgame_scene = null
var last_microgame = null # For queue freeing the old one during the transition
# Checking if the player lost or not so they can retry
var lost = false

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
	while microgame_scene == last_microgame_scene:
		microgame_scene = microgames.pick_random()
	#Sets the current game as the new "last_microgame"
	if lost:
		microgame_scene = last_microgame_scene
	last_microgame_scene = microgame_scene
		
	#Instantiates the microgame, adds it as a child, and centers it.
	var microgame = microgame_scene.instantiate()
	# Transition
	if lost:
		await Transition.transition("Spinning")
	else:
		await Transition.transition(microgame.verb)
	if last_microgame != null:
		last_microgame.queue_free()
	add_child(microgame)
	print("added microgame")
	#Position line could be replaced if container is used later on
	microgame.position = Vector2(576, 324)
	
	#Sets the difficulty/speed. Does nothing right now.
	microgame.start(1.0)
	#Times the game
	await get_tree().create_timer(3.0).timeout
	
	#Checks if the game was won and then deletes the instance
	if microgame.did_win:
		print("WIN")
		lost = false
	else:
		print("LOSE")
		lost = true
	last_microgame = microgame
