extends Path3D

@export var enemy_scene: PackedScene
@export var difficulty_manager: Node

@onready var timer: Timer = $Timer

var random_duration

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.start()


func _on_timer_timeout() -> void:
	spawn_enemy()
	generate_random_duration()
	timer.wait_time = random_duration
	timer.start()

func spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	new_enemy.max_health = difficulty_manager.get_enemy_health()
	add_child(new_enemy)


func generate_random_duration():
	var timer_min = difficulty_manager.get_spawn_time_min()
	var timer_max = difficulty_manager.get_spawn_time_max()
	random_duration = randf_range(timer_min, timer_max)


func _on_difficulty_manager_stop_spawning_enemies() -> void:
	timer.stop()
