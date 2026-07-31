extends Control



func _on_button_pressed() -> void:
	%SFX_Example.play()
	


func _on_return_button_pressed() -> void:
	Settings._saveSettings() # Saves any changes to audio
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
