class_name EnemyBase


extends PathFollow2D


@export var speed: float = 100.0



func _physics_process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio > 0.99:
		queue_free()
