extends "res://Scripts/microgame_base.gd"

var reel_power := 50.0
var max_power := 100.0

var fish_strength := 20.0 
var mash_strength := 12.0
var game_over = false
@onready var victoryscreen = $VictoryMessage

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if game_over == false:
			reel_power += mash_strength
			$FishingPole.pull()
			$Fish.reel_progress = reel_power / 40.0
		else:
			pass
		
		
func _process(delta):
	reel_power -= fish_strength * delta
	reel_power = clamp(reel_power, 0, max_power)
	$UI/ReelBar.value = reel_power
	
	if reel_power >= max_power:
		win()
		victoryscreen.visible = true
		victoryscreen.scale = Vector2.ZERO
		
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.set_ease(Tween.EASE_OUT)
		
		tween.tween_property(
			victoryscreen,
			"scale",
			Vector2.ONE,
			0.5
		)
		
		game_over = true
		$Fish.queue_free()
		$FishingPole.queue_free()
		
		
		

func setup_difficulty(level):
	match level:
		1:
			fish_strength = 15
			mash_strength = 14
		2:
			fish_strength = 20
			mash_strength = 12
		3:
			fish_strength = 30
			mash_strength = 10
		
