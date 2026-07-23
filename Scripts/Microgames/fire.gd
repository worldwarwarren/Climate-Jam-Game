extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if "isFuel" in area:
		if area.isFuel:
			scale += Vector2(0.5,0.5)
		else:
			scale -= Vector2(0.1,0.1)
	area.queue_free()
