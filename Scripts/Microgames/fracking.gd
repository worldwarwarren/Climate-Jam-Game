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
	
	if Input.is_action_just_pressed("ui_left"):
		playerdir("Left")
	if Input.is_action_just_pressed("ui_right"):
		playerdir("Right")
	if Input.is_action_just_pressed("ui_up"):
		playerdir("Up")
	if Input.is_action_just_pressed("ui_down"):
		playerdir("Down")
	
	
func start(speed):
	dir_list = []
	for i in 3:
		dir_list.append(directions.pick_random())
	arrow.text = dir_list[0]
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
		arrow.text = "↑"
	elif direction == "Down":
		arrow.text= "↓"
	elif direction == "Left":
		arrow.text = "←"
	elif direction == "Right":
		arrow.text = "→"
	elif direction == "Done":
		arrow.text = "👍"
	
func apply_shake(strength):
	shake_strength = strength

func screen_shake(delta):
	var random_offset = Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		camera.offset = random_offset
	else:
		camera.offset = Vector2.ZERO
