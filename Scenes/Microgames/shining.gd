extends "res://Scripts/microgame_base.gd"

@onready var windows = $WindowGrid.get_children()

var sequence = []
var player_index = 0
var showing_sequence = true

func generate_sequence():
	sequence.clear()
	for i in range(3):
		var index = randi() % windows.size()
		sequence.append(index)
		
func show_sequence():
	showing_sequence = true
	for index in sequence:
		await flash_window(index)
		await get_tree().create_timer(0.2).timeout
	showing_sequence = false
	player_index = 0
	
func flash_window(index):
	var window = windows[index]
	window.set_on(true)
	await get_tree().create_timer(0.3).timeout
	window.set_on(false)
	
func _ready():
	await get_tree().create_timer(0.5).timeout
	generate_sequence()
	connect_windows()
	await show_sequence()
	
func connect_windows():
	for i in range(windows.size()):
		windows[i].clicked.connect(_on_window_clicked.bind(i))
		

func _on_window_clicked(index):
	if showing_sequence:
		return
	if index == sequence[player_index]:
		player_index += 1
		if player_index >= sequence.size():
			win()
	else:
		lose()
