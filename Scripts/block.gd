extends StaticBody2D

@export var block_point = 5
@export var block_live = 1
@onready var sprite_node = get_node("Sprite2D")

var damage_colors = {
	1: 0.25,
	2: 0.50,
	3: 0.75
}

func handle_hit(hit_position: Vector2) -> void:
	GameManager.spawn_powerup(hit_position)
	check_lives()

func _on_timer_spawn_timeout() -> void:
	print("reset droped")
	GameManager.is_droped = false
	
func check_lives():
	block_live -= 1
	
	if block_live <= 0:
		add_points()
		
		get_parent().get_parent().call_deferred("check_exists_blocks")
		get_parent().remove_child(self)
		
		queue_free()
	else:
		_on_damage_hit(block_live)
		
func add_points(point: int = block_point):
	GameManager.add_point(point)
	
func _on_damage_hit(current_live: int):
	var color_val = damage_colors.get(current_live, 1.0)
	sprite_node.modulate = Color(color_val, color_val, color_val, 1.0)
	
