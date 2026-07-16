extends Node


signal spawn_pool_object(position: Vector2, scene: PackedScene)

signal player_take_damage(damage: int)


func emit_player_take_damage(damage: int) -> void:
	player_take_damage.emit(damage)

func emit_spawn_pool_object(position: Vector2, scene: PackedScene) -> void:
	spawn_pool_object.emit(position, scene)
