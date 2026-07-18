extends Area2D

func _process(delta: float) -> void:
	position.y += 1


func _on_area_entered(area: Area2D) -> void:
	get_parent().get_parent().total_drops -= 1
	queue_free()
