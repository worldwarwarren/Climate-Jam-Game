extends "res://Scripts/microgame_base.gd"

@onready var hose = $Hose

func _ready() -> void:
	hose.rotationGoal = 50*difficulty


func _on_hose_spray() -> void:
	win()
