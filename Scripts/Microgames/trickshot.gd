extends "res://Scripts/microgame_base.gd"

var gravityActive = false
const GRAV = 9.8
const SPEED = 1400
var chosenAngle: int
var direction = -1
@onready var Bar = $Bar
@onready var Ball = $Ball
@onready var ThrowSound = $ThrowSound
@onready var TrashcanSound = $TrashcanSound

func _physics_process(delta: float) -> void:
	if difficulty > 1:
		$Trashbag1.visible = true
		if difficulty > 2:
			$Trashbag2.visible = true
	if gravityActive:
		Ball.velocity.y += 1400*delta
		Ball.rotation_degrees += 5
	else:
		Bar.rotation_degrees += difficulty*direction
		if Bar.rotation_degrees >= 0 or Bar.rotation_degrees <= -90:
			direction *= -1
	if Input.is_action_just_pressed("ui_accept"):
		ThrowSound.play()
		chosenAngle = abs(Bar.rotation_degrees)
		#chosenAngle = 55
		print(chosenAngle)
		Ball.velocity.x = SPEED*cos(deg_to_rad(chosenAngle))
		Ball.velocity.y = -SPEED*sin(deg_to_rad(chosenAngle))
		print(Ball.velocity)
		gravityActive = true
	$Ball.move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	TrashcanSound.play()
	win()
