extends "res://Scripts/microgame_base.gd"

@onready var CarScene = preload("res://Scenes/MicrogameParts/npc_car.tscn")
const spawnPos = [470,682]
var crashed = false

func _ready() -> void:
	spawnCar()
	did_win = true

func spawnCar():
	var car = CarScene.instantiate()
	car.position.y = -175
	car.position.x = spawnPos.pick_random()
	car.SPEED = 5
	add_child(car)


func _on_area_2d_area_exited(area: Area2D) -> void:
	call_deferred("spawnCar")


func _on_player_car_crashed() -> void:
	crashed = true
	did_win = false
	lose()
