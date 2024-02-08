extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D

@export var clickable_range: float = 100.0


func _process(delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * clickable_range
	ray_cast_3d.force_raycast_update()
	printt(ray_cast_3d.get_collider(), ray_cast_3d.get_collision_point())
