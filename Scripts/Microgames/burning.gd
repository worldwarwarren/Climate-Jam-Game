extends "res://Scripts/microgame_base.gd"

const max_size = Vector2(1.0,1.0)
const min_size = Vector2(0.08,0.08)
var potential_spawns = [Vector2(234,365),Vector2(918,365),Vector2(427,493),Vector2(725,493),Vector2(576,500),Vector2(141,200), Vector2(1011,200)]
@onready var Fire = $Fire
@onready var ItemScene = preload("res://Scenes/MicrogameParts/burningitem.tscn")
var fuel_left = 4

func _ready() -> void:
	did_win = true
	potential_spawns.shuffle() # randomizing order
	for spawn in potential_spawns:
		spawnItem(spawn)

func spawnItem(spawn_pos):
	var Item = ItemScene.instantiate()
	Item.position = spawn_pos
	if fuel_left > 0:
		Item.isFuel = true
		fuel_left -= 1
	else:
		Item.isFuel = false
	add_child(Item)

func _process(delta: float) -> void:
	if Fire != null:
		Fire.scale -= Vector2(0.004,0.004)
		if Fire.scale > max_size:
			Fire.scale = max_size
		elif Fire.scale < min_size:
			Fire.queue_free()
			did_win = false
