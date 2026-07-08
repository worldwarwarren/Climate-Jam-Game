extends Node

signal won
signal lost
@export var verb: String

var did_win = false

func start(speed):
	pass
	
func win():
	if not did_win:
		did_win = true
		emit_signal("won")
		print("has won")

func lose():
	emit_signal("lost")
