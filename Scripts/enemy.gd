extends PathFollow3D

@export var speed: float = 5.1


func _process(delta: float) -> void:
	progress += delta * speed
