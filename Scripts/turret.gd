extends Node3D

@export var projectile: PackedScene
@export var turret_range := 10.0

var enemy_path: Path3D
var target: PathFollow3D

@onready var right_barrel: MeshInstance3D = $TurretBase/TurretTop/Visor/RightBarrel
@onready var left_barrel: MeshInstance3D = $TurretBase/TurretTop/Visor/LeftBarrel
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target:
		look_at(target.global_position, Vector3.UP, true)


func _on_timer_timeout() -> void:
	if target:
		animation_player.play("Fire")
		
		var shot_right = projectile.instantiate()
		add_child(shot_right)
		shot_right.global_position = right_barrel.global_position
		shot_right.direction = global_transform.basis.z
		
		var shot_left = projectile.instantiate()
		add_child(shot_left)
		shot_left.global_position = left_barrel.global_position
		shot_left.direction = global_transform.basis.z


func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 0
	
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			if enemy.progress > best_progress:
				var distance := global_position.distance_to(enemy.global_position)
				if distance < turret_range:
					best_target = enemy
					best_progress = enemy.progress
	
	return best_target
