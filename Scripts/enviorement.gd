extends Node2D

@onready var reset_timer = $ResetTimer
@onready var audio_death: AudioStreamPlayer2D = $AudioDeath

func _on_role_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		audio_death.play()
		
		if GameManager.lives > 1:
			GameManager.lives -= 1
			body.reset_position()
		else:
			GameManager.reset_game()
			reset_timer.start()
	else:
		body.queue_free()

func _on_reset_timer_timeout() -> void:
	GameManager.reset_game()
	get_tree().reload_current_scene()
