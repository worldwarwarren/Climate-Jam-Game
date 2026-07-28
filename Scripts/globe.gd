extends Control
@onready var main_node = get_tree().current_scene

func _ready() -> void:
	if main_node.name == "Victory":
		$AnimatedSprite2D.play("dirtiest")
	else:
		$AnimatedSprite2D.play("clean")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
