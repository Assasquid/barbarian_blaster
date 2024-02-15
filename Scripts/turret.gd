extends Node3D

@export var projectile: PackedScene
@export var turret_range := 10.0

var enemy_path: Path3D
var target: PathFollow3D

@onready var visor: MeshInstance3D = $TurretBase/TurretTop/Visor
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target:
		look_at(target.global_position, Vector3.UP, true)


func _on_timer_timeout() -> void:
	if target:
		animation_player.play("Fire")
		
		var round_shots = projectile.instantiate()
		add_child(round_shots)
		round_shots.global_position = visor.global_position
		round_shots.direction = global_transform.basis.z


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
