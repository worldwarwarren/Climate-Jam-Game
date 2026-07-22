extends "res://Scripts/microgame_base.gd"
var hunt_score = 0
var target = 0
@onready var Animal_Scene = preload("res://Scenes/MicrogameParts/HuntingAnimal.tscn")
@onready var AnimalContainer = $"Animal Container"
@onready var Score_Label = $CanvasLayer/UI/Label

func _ready():
	start(1.0)

func start(speed):
	target = randi_range(2, 5)
	Score_Label.text = ("Shoot " + str(target))
	print("Target: ", target)
	var count = 0
	while count < 9:
		var animal = Animal_Scene.instantiate()
		animal.position = Vector2(
			randi_range(-500, 500),
			randi_range(-250, 250)
			)
		animal.clicked.connect(_on_animal_clicked)
		AnimalContainer.add_child(animal)
		count += 1
		print(count)

func _on_animal_clicked():
	hunt_score += 1
	Score_Label.text = ("Shoot " + str(target - hunt_score) + " more")
	
	if hunt_score >= target:
		win()
