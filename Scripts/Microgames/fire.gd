extends Area2D
@onready var FireSound = $FireGrowth
@onready var FireCrackling = $FireCrackling


func _on_area_entered(area: Area2D) -> void:
	if "isFuel" in area:
		if area.isFuel:
			FireSound.play()
			FireCrackling.set_volume_db(FireCrackling.volume_db + 20)
			scale += Vector2(0.5,0.5)
		else:
			scale -= Vector2(0.1,0.1)
	area.queue_free()
