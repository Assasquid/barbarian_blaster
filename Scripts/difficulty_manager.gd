extends Node

signal stop_spawning_enemies

@export var game_length := 180.0
@export var spawn_time_min_curve: Curve
@export var spawn_time_max_curve: Curve
@export var enemy_health_curve: Curve

@onready var bank = get_tree().get_first_node_in_group("bank")

@onready var timer: Timer = $Timer

var minutes_left: int
var seconds_left: int


func _ready() -> void:
	timer.start(game_length)


func _process(delta: float) -> void:
	bank.time_left = time_to_minutes_seconds(timer.time_left)


func time_to_minutes_seconds(time_remaining: float) -> String:
	minutes_left = int(time_remaining / 60)
	time_remaining -= minutes_left * 60
	seconds_left = int(time_remaining)
	
	if seconds_left < 10:
		return str(minutes_left) + ":" + "0" + str(seconds_left)
	else:
		return str(minutes_left) + ":" + str(seconds_left)



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
