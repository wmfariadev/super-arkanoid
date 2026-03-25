extends Node2D

@onready var audio_level_up: AudioStreamPlayer2D = $AudioLevelUp

func _ready() -> void:
	audio_level_up.play()
	
