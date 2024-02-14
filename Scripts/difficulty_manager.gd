extends Node

signal stop_spawning_enemies

@export var game_length := 30.0
@export var spawn_time_min_curve: Curve
@export var spawn_time_max_curve: Curve
@export var enemy_health_curve: Curve
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.start(game_length)


func game_progress_ratio() -> float:
	return 1.0 - (timer.time_left / game_length)


func get_spawn_time_min() -> float:
	return spawn_time_min_curve.sample(game_progress_ratio())


func get_spawn_time_max() -> float:
	return spawn_time_max_curve.sample(game_progress_ratio())


func get_enemy_health() -> int:
	return enemy_health_curve.sample(game_progress_ratio())


func _on_timer_timeout() -> void:
	stop_spawning_enemies.emit()
