extends Area2D

@export var SPEED: int

func _process(delta: float) -> void:
	position.y += SPEED
	if position.y > 740:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("crash"):
		body.crash()
