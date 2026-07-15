extends CharacterBody2D

signal Crashed
const SPEED = 10
const minmax = Vector2(452,700)
var takingInput = true

func _physics_process(delta: float) -> void:
	move_and_slide()
	if takingInput:
		if Input.is_action_pressed("ui_left") and position.x > minmax.x:
			position.x -= 10
		if Input.is_action_pressed("ui_right") and position.x < minmax.y:
			position.x += 10

func crash():
	print("crashed")
	takingInput = false
	Crashed.emit()
