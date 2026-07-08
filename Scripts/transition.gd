extends Node2D

# The transition is sort of a placeholder right now in terms of looks

@export_category("Children")
@export var WorldKept: Label
@export var _animation_player: AnimationPlayer

func transition(verb):
	WorldKept.text = "And The World Kept " + verb + "!"
	_animation_player.play("transition1")
	await _animation_player.animation_finished
	_animation_player.play("transition2") # so that the stuff doesn't load until it can be visible
