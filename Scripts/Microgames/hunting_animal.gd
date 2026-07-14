extends Node2D
var speed = 100
var target_position = Vector2.ZERO

func _ready():
	pick_new_position()
	
func _process(delta):
	position = position.move_toward(target_position, speed * delta)
	
	if position.distance_to(target_position) < 5:
		pick_new_position()

func pick_new_position():
	target_position = Vector2(
		randi_range(100, 1000),
		randi_range(100, 500)
	)
	var speed = randf_range(75,150)



signal clicked

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		emit_signal("clicked")
		queue_free()
