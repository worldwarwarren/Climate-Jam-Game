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
@onready var IntermissionSound = $IntermissionSfx
@onready var DifficultySound = $DifficultySfx
@onready var globes = [$CanvasLayer/DifficultyChange/Globe,$CanvasLayer/ColorRect/Globe]

func transition(verb, score, controlType, new_diff,difficulty):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),true) # Muting sfx so sound effects dont play mid transition when they shouldnt
	for globe in globes:
		globe.spin(difficulty)
	WorldKept.text = "And The World Kept " + verb + "!"
	ScoreLabel.text = "Score: " + str(score)
	$CanvasLayer/DifficultyChange/Score.text = "Score: " + str(score)
	match controlType:
		0:
			Controls.text = "Mouse!"
		1:
			Controls.text = "Arrow Keys!"
		2:
			Controls.text = "Spacebar!"
	
	if new_diff:
		DifficultySound.play()
		_animation_player.play("difficulty_change")
		await _animation_player.animation_finished
	IntermissionSound.play()
	_animation_player.play("transition1")
	await _animation_player.animation_finished
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),false)
	_animation_player.play("transition2") # so that the stuff doesn't load until it can be visible

func _process(delta: float) -> void:
	TimeLeft.text = str(ceili(GameTimer.time_left))
	if ceili(GameTimer.time_left) <= 3:
		TimeLeft.text = str(ceili(GameTimer.time_left)) + "!"
