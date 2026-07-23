extends Area2D

@export var isFuel: bool
@onready var _sprite = $Label # Will be changed to a sprite later
var drag = false

func _ready() -> void:
	if isFuel:
		_sprite.text = "🪵"
	else:
		_sprite.text = "💧"
	

func _process(delta: float) -> void:
	if drag:
		position = get_global_mouse_position()

# Letting go of the mouse
func _unhandled_input(event: InputEvent) -> void:
	if drag and event is InputEventMouseButton and not event.is_pressed():
		drag = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		drag = true
