extends CanvasLayer
@onready var buttons = $Buttons.get_children()
@onready var SelectSound = $MenuSelectSound


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true
func _ready():
	for button in buttons:
		button.pivot_offset = button.size / 2
		button.mouse_entered.connect(_on_button_hover.bind(button))
		button.mouse_exited.connect(_on_button_exit.bind(button))


func _on_button_hover(button):
	SelectSound.set_pitch_scale(randf_range(0.9, 1.4))
	SelectSound.play()
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.2,1.2), 0.15)
func _on_button_exit(button):
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1,1), 0.15)


func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false
	


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),false)
