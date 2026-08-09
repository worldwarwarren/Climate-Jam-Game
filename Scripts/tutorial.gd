extends Control
@onready var buttons = $Buttons.get_children()
@onready var SelectSound = $MenuSelectSound

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

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
