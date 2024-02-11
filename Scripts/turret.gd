extends Node3D

@export var projectile: PackedScene

@onready var right_barrel: MeshInstance3D = $TurretBase/TurretTop/Visor/RightBarrel
@onready var left_barrel: MeshInstance3D = $TurretBase/TurretTop/Visor/LeftBarrel


func _on_timer_timeout() -> void:
	var shot_right = projectile.instantiate()
	add_child(shot_right)
	shot_right.global_position = right_barrel.global_position
	var shot_left = projectile.instantiate()
	add_child(shot_left)
	shot_left.global_position = left_barrel.global_position
