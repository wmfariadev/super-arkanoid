extends Node2D

func _process(delta: float) -> void:
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
