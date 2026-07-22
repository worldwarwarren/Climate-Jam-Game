extends Node2D
var score = 0

@onready var Transition = $Transition
@onready var GameTimer = $GameTimer
@onready var MicrogameContainer = $MicrogameContainer

# List of microgames per difficulty
var microgamesEasy = [
	#preload("res://Scenes/Microgames/PressButton.tscn"),
	#preload("res://Scenes/Microgames/BluePressButton.tscn"),
	preload("res://Scenes/Microgames/Trickshot.tscn"),
	preload("res://Scenes/Microgames/Commuting.tscn"),
	preload("res://Scenes/Microgames/Fishing.tscn"),
	preload("res://Scenes/Microgames/Fracking.tscn"),
	preload("res://Scenes/Microgames/Consuming.tscn"),
	preload("res://Scenes/Microgames/Sweating.tscn"),
	preload("res://Scenes/Microgames/Shining.tscn")
]
var microgamesMid = [
	preload("res://Scenes/Microgames/Trickshot.tscn"),
	preload("res://Scenes/Microgames/Hunting.tscn"),
	#preload("res://Scenes/Microgames/BluePressButton.tscn"),
	preload("res://Scenes/Microgames/Commuting.tscn"),
	preload("res://Scenes/Microgames/Fishing.tscn"),
	preload("res://Scenes/Microgames/Fracking.tscn"),
	preload("res://Scenes/Microgames/Consuming.tscn"),
	preload("res://Scenes/Microgames/Sweating.tscn"),
	preload("res://Scenes/Microgames/Sawing.tscn")
]
var microgamesHard = [
	preload("res://Scenes/Microgames/Trickshot.tscn"),
	preload("res://Scenes/Microgames/Hunting.tscn"),
	preload("res://Scenes/Microgames/Fishing.tscn"),
	preload("res://Scenes/Microgames/Hosing.tscn"),
	preload("res://Scenes/Microgames/Fracking.tscn"),
	preload("res://Scenes/Microgames/Consuming.tscn"),
	preload("res://Scenes/Microgames/Sweating.tscn"),
	preload("res://Scenes/Microgames/Sawing.tscn")
]

#Lists all of the microgames available currently
@onready var microgames = microgamesEasy
#Checks the last microgame that has been played
#Used later to prevent repeats
var last_microgame_scene = null
@onready var microgames_left = microgamesEasy.size() # Tracking microgames that have been used already
var last_microgame = null # For queue freeing the old one during the transition
# Checking if the player lost or not so they can retry
var lost = false
# Difficulty
var difficulty = 1

func _ready():
	game_loop()
	
	
#Function to loop the microgames
func game_loop():
	while true:
		await play_microgame()

#Function to play a microgame
func play_microgame():
	if microgames_left == 0:
		difficulty += 1
		# Changing the list of current available microgames
		match difficulty:
			2:
				microgames = microgamesMid
			3:
				microgames = microgamesHard
		microgames_left = microgames.size()
		print("Difficulty " + str(difficulty))
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
		await Transition.transition("Spinning", score)
	else:
		await Transition.transition(microgame.verb, score)
	if last_microgame != null:
		last_microgame.queue_free()
	MicrogameContainer.add_child(microgame)
	print("added microgame")
	#Position line could be replaced if container is used later on
	
	#Sets the difficulty/speed. Does nothing right now.
	microgame.start(difficulty)
	#Times the game
	GameTimer.start(microgame.time)
	await GameTimer.timeout
	
	#Checks if the game was won and then deletes the instance
	if microgame.did_win:
		print("WIN")
		score += 1
		print(score)
		lost = false
		microgames_left -= 1
	else:
		print("LOSE")
		lost = true
	last_microgame = microgame
