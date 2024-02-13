extends Path3D

@export var enemy_scene: PackedScene
@export var timer_min := 1.3
@export var timer_max := 2.6

var timer: Timer
var random_duration

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)
	
	generate_random_duration()
	
	timer.start(random_duration)
	print("Starting timer with random duration = " + str(random_duration))


func spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)


func generate_random_duration():
	random_duration = randf_range(timer_min, timer_max)


func _on_timer_timeout() -> void:
	spawn_enemy()
	generate_random_duration()
	timer.start(random_duration)
	print("REstarting timer with random duration = " + str(random_duration))
