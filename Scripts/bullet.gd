extends Area2D

var speed = 250

func _physics_process(delta: float) -> void:
	global_position.y -= speed * delta


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	body.check_lives()
	body.add_points(1)
