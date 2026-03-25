extends CharacterBody2D

var speed = 400
@export var shoot_power_up_timer: Timer
var bullet_scene = preload("res://Scenes/bullet.tscn")
var max_bullet: int = 20
var current_bullet: int = 0
@onready var audio_shoot: AudioStreamPlayer2D = $AudioShoot

func _ready() -> void:
	GameManager.on_power_up.connect(spawn_bullet)

func _physics_process(delta: float) -> void:
	
	velocity.x = 0
	if (GameManager.started):
		if Input.is_action_pressed("left"):
			velocity.x -= speed
		elif Input.is_action_pressed("right"):
			velocity.x += speed
		 	
		move_and_collide(velocity * delta)

func spawn_bullet():
	# criando tiro da esquerda
	
	audio_shoot.play()
	
	var left_shoot_instance = bullet_scene.instantiate()
	get_parent().add_child(left_shoot_instance)
	left_shoot_instance.global_position.x = global_position.x - 40
	left_shoot_instance.global_position.y = global_position.y - 25
	
	var right_shoot_instance = bullet_scene.instantiate()
	get_parent().add_child(right_shoot_instance)
	right_shoot_instance.global_position.x = global_position.x + 40
	right_shoot_instance.global_position.y = global_position.y - 25
	
	current_bullet += 2
	
	if current_bullet < max_bullet:
		shoot_power_up_timer.start()
	else:
		shoot_power_up_timer.stop()
		current_bullet = 0

func _on_shoot_power_up_timer_timeout() -> void:
	spawn_bullet()
