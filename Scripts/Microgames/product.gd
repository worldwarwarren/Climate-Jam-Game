extends RigidBody2D

@export var Hitbox: CollisionShape2D
var drag = false
@onready var mouse_pin = $PinJoint2D # There's a pinjoint here that allows for the rigid body to rotate around and be linked to a shapeless static body2d. If the pinjoint is kept on the mouse position, the rigid body can be dragged with it
@onready var fake_body = $PinJoint2D/FakeBody # This one is a shapeless static body2d used to link with the rigid body

func _physics_process(delta: float) -> void:
	mouse_pin.global_position = get_global_mouse_position()
	if not get_parent().takingInput:
		mouse_pin.node_b = NodePath() # Voids the connection when not holding down
		drag = false
		angular_damp = 0


# Letting go of the mouse
func _unhandled_input(event: InputEvent) -> void:
	if drag and event is InputEventMouseButton and not event.is_pressed() and get_parent().takingInput:
		mouse_pin.node_b = NodePath() # Voids the connection when not holding down
		drag = false
		angular_damp = 0

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and get_parent().takingInput and not drag:
		if event.is_pressed():
			mouse_pin.node_b = mouse_pin.get_path_to(self) # Connects to the rigid body
			drag = true
			angular_damp = 10
