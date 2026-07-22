extends Area2D

signal clicked

@onready var sprite = $Sprite2D

func _ready():
	input_pickable = true
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		clicked.emit()
		
func set_on(value: bool):
	if value:
		sprite.modulate = Color(1, 1, 0)
	else:
		sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)
