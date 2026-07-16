extends Node2D

var target_rotation := 0.0
var return_speed := 10.0

@onready var line = $Line2D
@onready var fish = $"../Fish"

func _process(delta):
	rotation = lerp(rotation, target_rotation, return_speed * delta)
	
	line.set_point_position(0, Vector2.ZERO)
	line.set_point_position(1, to_local(fish.global_position))
	
func pull():
	target_rotation = deg_to_rad(15)
	await get_tree().create_timer(0.1).timeout
	target_rotation = 0
