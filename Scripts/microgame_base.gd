extends Node

signal won
signal lost
@export var verb: String
@export var time: float

var did_win = false

func start(speed):
	time = time/speed
	
func win():
	if not did_win:
		did_win = true
		emit_signal("won")
		print("has won")

func lose():
	emit_signal("lost")
