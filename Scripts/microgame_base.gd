extends Node

signal won
signal lost
@export var verb: String
@export var difficulty: int # The actual difficulty, used for changing stuff that isn't time
@export var time: float # Time for the ingame timer
@export var difficultyTimes: Array[float] # Times that determine the time based on the difficulty

var did_win = false

func start(speed):
	difficulty = speed
	if difficultyTimes.size() >= speed:
		time = difficultyTimes[speed-1]
	
	
func win():
	if not did_win:
		did_win = true
		emit_signal("won")
		print("has won")

func lose():
	emit_signal("lost")
