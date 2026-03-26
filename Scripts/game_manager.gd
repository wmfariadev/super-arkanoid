extends Node

var started: bool = false
var drop_probability = 0.9
var power_up_scene = preload("res://Scenes/power_up.tscn")
var timer_spawn: Timer
var lives: int = 3
var points: int = 0
var record: int = 0
var current_level = 1
var total_level = 2

signal on_power_up

func _ready() -> void:
	timer_spawn = Timer.new()
	add_child(timer_spawn)
	timer_spawn.wait_time = 10.0
	timer_spawn.one_shot = true

func spawn_powerup(position_item: Vector2):
	
	if !timer_spawn.is_stopped():
		return
	
	if randf() < drop_probability:
		var item = power_up_scene.instantiate()
		item.position = position_item
		get_parent().add_child(item)
		timer_spawn.start()

func reset_game():
	started = false
	timer_spawn.stop()
	update_record()
	reset_lives()
	reset_points()
	reset_current_level()

func reset_lives():
	lives = 3

func add_point(point: int):
	points += point

func reset_points():
	points = 0
	
func update_record():
	if points > record:
		record = points	
	
func change_level():
	if current_level < total_level:
		current_level += 1
		var next_scene = "res://Scenes/level" + str(current_level) + ".tscn"
		get_tree().change_scene_to_file(next_scene)
	else:
		get_tree().change_scene_to_file("res://Scenes/level3.tscn")
		
func reset_current_level():
	current_level = 1
	var next_scene = "res://Scenes/level" + str(current_level) + ".tscn"
	get_tree().change_scene_to_file(next_scene)
