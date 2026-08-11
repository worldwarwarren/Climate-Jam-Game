extends Control
@onready var buttons = $Buttons.get_children()
@onready var SelectSound = $MenuSelectSound
var step = 0

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


func _on_no_pressed() -> void:
	if step < 2:
		Settings.world_destroyed = true
		_on_button_pressed()
	else:
		Settings.world_destroyed = false
		get_tree().change_scene_to_file("res://Scenes/Microgames/Planting.tscn")


func _on_yes_pressed() -> void:
	step += 1
	match step:
		1:
			$Label.visible = false
			$Label2.text = "Are you sure?"
		2:
			$Label2.text = "Don't you think it's too late?"
		3:
			Settings.world_destroyed = true
			_on_button_pressed()
