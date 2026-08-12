extends Node2D

@onready var Seed = $Seed
@onready var animation_player = $AnimationPlayer
@onready var transition = $Transition
@onready var theme = $Theme

var planting = false
var themequietdown = false

func _ready() -> void:
	$Background.color = Color(0.48,0.08,0.57,1)
	await transition.transition("Planting",0,0,false,4)
	planting = true
	$Background.color = Color(0.48,0.08,0.57,0)
	
func _process(delta: float) -> void:
	$Smoke.position.x += 0.05
	if planting:
		Seed.position = get_global_mouse_position()
	if themequietdown:
		theme.set_volume_db(theme.volume_db - 0.15)

func _on_hole_area_entered(area: Area2D) -> void:
	planting = false
	playtheme()
	transition.queue_free()
	animation_player.play("planting")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")

func playtheme():
	theme.play()
	await get_tree().create_timer(9.5).timeout
	themequietdown = true
