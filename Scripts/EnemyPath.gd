extends Path3D

@export var enemy_scene: PackedScene
@export var difficulty_manager: Node

@onready var timer: Timer = $Timer

var random_duration

func _ready() -> void:
	print(timer.wait_time)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()


func _on_timer_timeout() -> void:
	spawn_enemy()
	generate_random_duration()
	timer.wait_time = random_duration
	timer.start()

func spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)


func generate_random_duration():
	var timer_min = difficulty_manager.get_spawn_time_min()
	var timer_max = difficulty_manager.get_spawn_time_max()
	random_duration = randf_range(timer_min, timer_max)
