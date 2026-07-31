extends Control
@onready var buttons = $CanvasLayer/VBoxContainer.get_children()


func _ready():
	Settings._loadSettings()
	$AnimationPlayer.play("menu_in")
	for button in buttons:
		button.mouse_entered.connect(_on_button_hover.bind(button))
		button.mouse_exited.connect(_on_button_exit.bind(button))
		button.pressed.connect(_on_button_pressed.bind(button))



func _on_button_hover(button):
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.2,1.2), 0.15)
func _on_button_exit(button):
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1,1), 0.15)
func _on_button_pressed(button):
	print(button.name + " pressed")



func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainGameScene.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Tutorial.tscn")
