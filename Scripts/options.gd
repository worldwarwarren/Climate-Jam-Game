extends Control



func _on_button_pressed() -> void:
	%SFX_Example.play()
	


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
