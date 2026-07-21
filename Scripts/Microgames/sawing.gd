extends "res://Scripts/microgame_base.gd"

@onready var TopHalf = $"Top Half"
@onready var Labels = $Health
@onready var Saw = $Saw
@onready var _animation_player = $AnimationPlayer
const cut_range_y = [400,600]
const cut_range_x = [570,680]
var goal_x = 0 # 0 is left, 1 is right
var tree_health = 35

func _process(delta: float) -> void:
	if tree_health > 0:
		$Health.text = "Tree Health: " + str(tree_health)
		if Saw.position.y <= cut_range_y[1] and Saw.position.y >= cut_range_y[0]:
			if goal_x == 0 and Saw.position.x <= cut_range_x[0]:
				tree_health -= 1
				goal_x = 1
			elif goal_x == 1 and Saw.position.x >= cut_range_x[1]:
				tree_health -= 1
				goal_x = 0
	else:
		Labels.visible = false
		Saw.visible = false
		win()
		_animation_player.play("cut")
		set_process(false)
