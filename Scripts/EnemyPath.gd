extends Path3D

@export var enemy_scene: PackedScene
@export var timer_min := 1.3
@export var timer_max := 5.0

#var timer: Timer
@onready var timer: Timer = $Timer

var random_duration
var enemy_number_debug

func _ready() -> void:
	enemy_number_debug = 1
	#timer = Timer.new()
	#add_child(timer)
	print(timer.wait_time)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	#generate_random_duration()
	
	#timer.start(random_duration)
	#print("Starting timer with random duration = " + str(random_duration))


func _on_timer_timeout() -> void:
	spawn_enemy()
	print("Spawning enemy: " + str(enemy_number_debug))
	generate_random_duration()
	#timer.start(random_duration)
	timer.wait_time = random_duration
	timer.start()
	print("Next enemy in: " + str(random_duration))
	enemy_number_debug += 1

func spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)


func generate_random_duration():
	random_duration = randf_range(timer_min, timer_max)
