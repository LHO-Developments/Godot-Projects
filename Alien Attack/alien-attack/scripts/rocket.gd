extends Area2D

@export var speed = 0;

func _physics_process(delta: float):
	global_position.x += speed;
