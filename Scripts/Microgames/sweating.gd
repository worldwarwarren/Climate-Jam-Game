extends "res://Scripts/microgame_base.gd"

@onready var Towel = $Towel
@onready var SweatDropScene = preload("res://Scenes/MicrogameParts/sweat_drop.tscn")
const x_range = [318,868]
const y_range = [275,450]
var total_drops = 0

func _ready() -> void:
	$MainTimer.start(time-0.5)

func _process(delta: float) -> void:
	if total_drops == 0:
		did_win = true
	else:
		did_win = false

func spawnSweat():
	var sweat = SweatDropScene.instantiate()
	sweat.position.x = randi_range(x_range[0],x_range[1])
	sweat.position.y = randi_range(y_range[0],y_range[1])
	total_drops += 1
	$"Sweat Container".add_child(sweat)


func _on_timer_timeout() -> void:
	spawnSweat()

# The second timer is to prevent sweat from spawning last second during the transition
func _on_main_timer_timeout() -> void:
	$SweatTimer.stop()
