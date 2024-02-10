extends Node3D

@export var turret: PackedScene


func _ready() -> void:
	var new_turret = turret.instantiate()
	add_child(new_turret)
