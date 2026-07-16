extends Node2D

var start_position: Vector2

@export var struggle_distance := 100.0
@export var smooth_speed := 5.0

var reel_progress := 0.5


func _ready():
	start_position = position


func _process(delta):
	var pull_position = lerp(
		-struggle_distance,
		struggle_distance,
		reel_progress
	)
	var wiggle = sin(Time.get_ticks_msec() / 150.0) * 10
	var target = start_position + Vector2(
		pull_position,
		wiggle
	)

	position = position.lerp(target, smooth_speed * delta)
