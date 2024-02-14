extends PathFollow3D

@export var speed: float = 5.1
@export var max_health := 30
@export var enemy_gold_reward := 15

@onready var base: Node3D = get_tree().get_first_node_in_group("base")
@onready var bank = get_tree().get_first_node_in_group("bank")
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var current_health: int:
	set(new_value):
		if new_value < current_health:
			animation_player.play("TakeDamage")
		current_health = new_value
		
		if current_health < 1:
			bank.money += enemy_gold_reward
			queue_free()


func _ready() -> void:
	current_health = max_health


func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1.0:
		base.take_damage()
		set_process(false)
		queue_free()
