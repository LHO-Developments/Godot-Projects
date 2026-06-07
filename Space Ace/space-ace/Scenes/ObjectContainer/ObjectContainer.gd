extends Node


@export var test_scene: PackedScene


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		on_spawn_pool_object(
			Vector2(
				randf_range(400,1000),
				randf_range(300,700),
			),
			test_scene
		)
		

func on_spawn_pool_object(position: Vector2, scene: PackedScene) -> void:
	call_deferred("spawn_deferred", position, scene)

func spawn_deferred(position: Vector2, scene: PackedScene) -> void:
	var ns: Poolable = scene.instantiate()
	ns.global_position = position
	add_child(ns)
	ns.activate()
