extends Node3D

@export var projectile: PackedScene

var enemy_path: Path3D

@onready var right_barrel: MeshInstance3D = $TurretBase/TurretTop/Visor/RightBarrel
@onready var left_barrel: MeshInstance3D = $TurretBase/TurretTop/Visor/LeftBarrel


func _physics_process(delta: float) -> void:
	var enemy = enemy_path.get_children().back()
	look_at(enemy.global_position, Vector3.UP, true)


func _on_timer_timeout() -> void:
	var shot_right = projectile.instantiate()
	add_child(shot_right)
	shot_right.global_position = right_barrel.global_position
	shot_right.direction = global_transform.basis.z
	var shot_left = projectile.instantiate()
	add_child(shot_left)
	shot_left.global_position = left_barrel.global_position
	shot_left.direction = global_transform.basis.z
