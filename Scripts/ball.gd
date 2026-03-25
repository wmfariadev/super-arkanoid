extends CharacterBody2D

var speed = 100
var speed_up = -250
var angle = [-200, -250, 250, 300]

@onready var audio_collision: AudioStreamPlayer2D = $AudioCollision

func _physics_process(delta: float) -> void:
	
	if !GameManager.started and Input.is_action_pressed("launch"):
		play_game()
	
	if GameManager.started:
		var collision = move_and_collide(velocity * delta)
		
		if collision != null:
			audio_collision.play()
			
			var collision_object = collision.get_collider()
			
			var bounce_velocity = velocity.bounce(collision.get_normal())
			var current_angle = rad_to_deg(bounce_velocity.angle())
			
			print(str(current_angle))
			
			var min_y_angle = 15.0
			
			if abs(current_angle) > (180 - min_y_angle):
				current_angle = (180 - min_y_angle) * sign(current_angle)
				
			var speed_current = bounce_velocity.length()
			velocity = Vector2.from_angle(deg_to_rad(current_angle)) * speed_current
			
			if collision_object.has_method("handle_hit"):
				collision_object.handle_hit(collision.get_position())


func play_game():
	GameManager.started = true
	velocity = Vector2(angle.pick_random(), speed_up)
	
func reset_position():
	var player = get_parent().get_node("Player")
	position = player.position + Vector2(0, -28)
	GameManager.started = false
	
