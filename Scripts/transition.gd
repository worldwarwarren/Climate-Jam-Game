extends Node2D

# The transition is sort of a placeholder right now in terms of looks

@export_category("Children")
@export var WorldKept: Label
@export var _animation_player: AnimationPlayer
@export var TimeLeft: Label
@export var ScoreLabel: Label
@export var Controls: Label
@export_category("External")
@export var GameTimer: Timer

func transition(verb, score, is_mouse):
	WorldKept.text = "And The World Kept " + verb + "!"
	ScoreLabel.text = "Score: " + str(score)
	if is_mouse:
		Controls.text = "Mouse!"
	else:
		Controls.text = "Keyboard!"
	
	_animation_player.play("transition1")
	await _animation_player.animation_finished
	_animation_player.play("transition2") # so that the stuff doesn't load until it can be visible

func _process(delta: float) -> void:
	TimeLeft.text = str(ceili(GameTimer.time_left)) + "!"
