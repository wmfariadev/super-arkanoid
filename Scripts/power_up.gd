extends CharacterBody2D

var fall_speed = 80
var rotation_speed = 60

# Implementar o timer do powerup para spawn somente a cada 10seg

func _physics_process(delta: float) -> void:
	velocity.y = fall_speed
	rotation_degrees += rotation_speed * delta
	
	var collision = move_and_collide(velocity * delta)
	check_power_up(collision)
	

func check_power_up(collision: KinematicCollision2D):
	if collision != null:
		var collision_object = collision.get_collider()
	
		if collision_object.name == "Player":
			queue_free()
			GameManager.on_power_up.emit()
	
