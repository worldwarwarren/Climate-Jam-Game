extends "res://Scripts/microgame_base.gd"

signal Full
var takingInput = true
const spawnRanges = [[100,330],[760,1052]]
@onready var productScene = preload("res://Scenes/MicrogameParts/product.tscn")
@onready var DetectionBox = $"Shopping Cart/DetectionBox"
@onready var Cart = $"Shopping Cart"
@onready var RightWall = $Boundaries/Wall2

func spawnProduct(type):
	var product = productScene.instantiate()
	if type > 2:
		product.Hitbox.shape = RectangleShape2D.new()
		if type == 3:
			product.Hitbox.shape.size = Vector2(100,65)
		else:
			product.Hitbox.shape.size = Vector2(40,350)
	elif type == 2:
		product.Hitbox.shape = CircleShape2D.new()
		product.Hitbox.shape.radius = 40
	else:
		product.Hitbox.shape = CapsuleShape2D.new()
		product.Hitbox.shape.height = 120
		product.Hitbox.shape.radius = 25
	var range = spawnRanges.pick_random()
	product.position = Vector2(randi_range(range[0],range[1]),100)
	add_child(product)

func _ready() -> void:
	spawnProduct(4)
	for i in 3:
		spawnProduct(randi_range(1,3))

func _process(delta: float) -> void:
	var item_count = DetectionBox.get_overlapping_bodies().size()
	$Label.text = str(item_count) + " Items In Cart!"
	if item_count == 4:
		did_win = true
	else:
		did_win = false
