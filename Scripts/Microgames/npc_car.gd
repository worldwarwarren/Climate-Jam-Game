extends Area2D

@export var SPEED: int
var animations = ["crash","crash_2"]

func _process(delta: float) -> void:
	position.y += SPEED
	if position.y > 740:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("crash"):
		body.crash()
		SPEED = 0
		$AnimationPlayer.play(animations.pick_random())
