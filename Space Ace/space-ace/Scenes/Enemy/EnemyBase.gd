class_name EnemyBase


extends PathFollow2D


@export var speed: float = 100.0


@export var explosion_scene: PackedScene


@onready var health_bar: HealthBar = $HealthBar;

@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_health_bar_died() -> void:
	SignalHub.emit_spawn_pool_object(global_position, explosion_scene);
	var tween: Tween = create_tween()
	tween.tween_property(sprite_2d, "modulate", Color("#ff0000"), 0.25)
	tween.tween_callback(queue_free)

func _physics_process(delta: float) -> void:
	progress += speed * delta
	if progress_ratio > 0.99:
		queue_free()


func _on_hitbox_hit(damage: int) -> void:
	health_bar.take_damage(damage)
