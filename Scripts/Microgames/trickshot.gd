extends "res://Scripts/microgame_base.gd"

var gravityActive = false
const GRAV = 9.8
const SPEED = 1400
var chosenAngle: int
var direction = -1
@onready var Bar = $Bar
@onready var Ball = $Ball

func _physics_process(delta: float) -> void:
	if gravityActive:
		Ball.velocity.y += 1400*delta
	else:
		Bar.rotation_degrees += 1*direction
		if Bar.rotation_degrees >= 0 or Bar.rotation_degrees <= -90:
			direction *= -1
	if Input.is_action_just_pressed("ui_accept"):
		chosenAngle = abs(Bar.rotation_degrees)
		#chosenAngle = 55
		print(chosenAngle)
		Ball.velocity.x = SPEED*cos(deg_to_rad(chosenAngle))
		Ball.velocity.y = -SPEED*sin(deg_to_rad(chosenAngle))
		print(Ball.velocity)
		gravityActive = true
	$Ball.move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	win()
