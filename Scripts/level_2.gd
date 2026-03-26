extends Node2D

@onready var audio_level_up: AudioStreamPlayer2D = $AudioLevelUp

func _ready() -> void:
	audio_level_up.play()
	
func _process(_delta: float) -> void:
	if Input.is_action_pressed("next_level_tests"):
		next_level() 
	
func check_exists_blocks():
	for group in get_children():
		for child in group.get_children():
			if child.name.contains("Block"):
				return true
	next_level()

func next_level():
	GameManager.started = false
	GameManager.change_level()
