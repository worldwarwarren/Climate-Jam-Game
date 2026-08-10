extends "res://Scripts/microgame_base.gd"

@onready var hose = $Hose
@onready var HoseSound = $HoseSound
@onready var BackgroundSFX = $BackgroundFire

func _ready() -> void:
	hose.rotationGoal = 50*difficulty


func _on_hose_spray() -> void:
	HoseSound.play()
	$AnimationPlayer.play("spray")
	win()
	await get_tree().create_timer(1.0).timeout
	BackgroundSFX.stop()
