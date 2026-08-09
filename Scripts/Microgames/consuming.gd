extends "res://Scripts/microgame_base.gd"

signal Full
var takingInput = true
const spawnRanges = [[100,330],[760,1052]]
@onready var productScene = preload("res://Scenes/MicrogameParts/product.tscn")
@onready var longRect = preload("res://Assets/Art/Sprites/giftwrap.png")
@onready var shortRect = preload("res://Assets/Art/Sprites/fruit box.png")
@onready var capsule = preload("res://Assets/Art/Sprites/juice.png")
@onready var circle = preload("res://Assets/Art/Sprites/melon.png")
@onready var DetectionBox = $"Shopping Cart/DetectionBox"
@onready var Cart = $"Shopping Cart"
@onready var RightWall = $Boundaries/Wall2
@onready var CashSound = $cashSFX

func spawnProduct(type):
	var product = productScene.instantiate()
	if type > 2:
		product.Hitbox.shape = RectangleShape2D.new()
		if type == 3:
			product.Hitbox.shape.size = Vector2(100,65)
			product.Sprite.texture = shortRect
		else:
			product.Hitbox.shape.size = Vector2(40,350)
			product.Sprite.texture = longRect
	elif type == 2:
		product.Hitbox.shape = CircleShape2D.new()
		product.Hitbox.shape.radius = 40
		product.Sprite.texture = circle
	else:
		product.Hitbox.shape = CapsuleShape2D.new()
		product.Hitbox.shape.height = 120
		product.Hitbox.shape.radius = 25
		product.Sprite.texture = capsule
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
		$Label.label_settings.font_color = Color.GREEN
		did_win = true
	else:
		$Label.label_settings.font_color = Color.RED
		did_win = false


func _on_detection_box_body_entered(body: Node2D) -> void:
	CashSound.set_pitch_scale(randf_range(0.9, 1.1))
	CashSound.play()
