extends "res://Scripts/microgame_base.gd"

@onready var pipe = $CanvasLayer/Pipe
@onready var arrow = $CanvasLayer/Arrow
@onready var camera = $Camera2D
var directions = [
	"Up",
	"Down",
	"Right",
	"Left",
]
var dir_list: Array

@export var random_strength = 10
var shake_fade = 5
var rng = RandomNumberGenerator.new()
var shake_strength = 0



func _process(delta: float):
	screen_shake(delta)
	if difficulty > 1:
		$CanvasLayer/Sky.color = Color.DIM_GRAY
		if difficulty > 2 :
			$CanvasLayer/Green.color = Color.SLATE_GRAY
	
	if Input.is_action_just_pressed("ui_left"):
		playerdir("Left")
	if Input.is_action_just_pressed("ui_right"):
		playerdir("Right")
	if Input.is_action_just_pressed("ui_up"):
		playerdir("Up")
	if Input.is_action_just_pressed("ui_down"):
		playerdir("Down")
	
	
func start(speed):
	difficulty = speed
	if difficultyTimes.size() >= speed:
		time = difficultyTimes[speed-1]
	dir_list = []
	for i in 3:
		dir_list.append(directions.pick_random())
	arrow.set_animation("Arrow")
	arrowchange(dir_list[0])
	print(dir_list)
	
func playerdir(direction):
	if dir_list.is_empty() == false:
		if dir_list[0] == direction:
			apply_shake(random_strength)
			dir_list.erase(direction)
			pipe.value += 1
			if dir_list.is_empty() == false:
				arrowchange(dir_list[0])
			else:
				arrowchange("Done")
				win()
			print(dir_list)
		else:
			print("That's not it.")
	pass
	
func arrowchange(direction):
	if direction == "Up":
		arrow.rotation_degrees = 270
	elif direction == "Down":
		arrow.rotation_degrees = 90
	elif direction == "Left":
		arrow.rotation_degrees = 180
	elif direction == "Right":
		arrow.rotation_degrees = 0
	elif direction == "Done":
		arrow.rotation_degrees = 0
		arrow.set_animation("Complete")
	
func apply_shake(strength):
	shake_strength = strength

func screen_shake(delta):
	var random_offset = Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		camera.offset = random_offset
	else:
		camera.offset = Vector2.ZERO
