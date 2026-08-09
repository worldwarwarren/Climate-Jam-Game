extends Control
#@onready var main_node = get_tree().current_scene
@export var stage: int = 1


func _ready() -> void:
	spin(stage)
	#if main_node.name == "Victory":
	#	$AnimatedSprite2D.play("dirtiest")
	#else:
	#	$AnimatedSprite2D.play("clean")

func spin(difficulty):
	match difficulty:
		1:
			$AnimatedSprite2D.play("clean")
		2:
			$AnimatedSprite2D.play("dirty")
		3:
			$AnimatedSprite2D.play("dirtier")
		4: # Only happens on victory screen
			$AnimatedSprite2D.play("dirtiest")
