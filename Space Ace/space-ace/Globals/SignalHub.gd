extends Node


signal spawn_pool_object(position: Vector2, scene: PackedScene)



func emit_spawn_pool_object(position: Vector2, scene: PackedScene) -> void:
	spawn_pool_object.emit(position, scene)
