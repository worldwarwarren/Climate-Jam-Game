extends Area2D

signal Spray
var takingInput = true
var drag = false
@export var rotationGoal: int
@export var water: ColorRect
@export var fire: Sprite2D
@export var bar: ProgressBar

func _process(delta: float) -> void:
	bar.max_value = rotationGoal
	bar.value = abs(rotation)
	if drag:
		look_at(get_global_mouse_position())
	if !Input.is_anything_pressed() or !takingInput:
		drag = false
	print(rotation)
	if abs(rotation) > rotationGoal:
		Spray.emit()
		takingInput = false
		if water.size.x <= 500: # Placeholder before we get actual assets
			water.size.x += 10
		else:
			fire.self_modulate.a -= 0.05
		
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and takingInput:
		if event.is_pressed():
			drag = true
