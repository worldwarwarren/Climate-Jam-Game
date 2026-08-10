extends Area2D

signal clicked

@onready var sprite = $Sprite2D
@onready var sound = $ShiningWindow

func _ready():
	input_pickable = true
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		sound.play()
		clicked.emit()
		
func set_on(value: bool):
	if value:
		sprite.frame = 1
	else:
		sprite.frame = 0
