extends Area2D

@export var speed = 0;

signal died;

func _physics_process(delta: float):
	global_position.x += -speed * delta;

# called custom signal to update score of game
func die():
	emit_signal("died");
	queue_free();

func _on_body_entered(body: Node2D) -> void:
	body.take_damage();
	die();
