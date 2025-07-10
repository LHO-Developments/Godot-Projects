extends Node2D
class_name Spawner;
const OBSTACLE = preload("res://Scenes/Obstacle/obstacle.tscn");
@onready var timer: Timer = $Timer

func create_obstacle() -> void:
	var obs = OBSTACLE.instantiate();
	
	var viewport: Rect2 = get_viewport_rect();
	obs.position.x = viewport.end.x + 150;
	
	var half = viewport.size.y / 2;
	obs.position.y = randf_range(half + 240, half - 50);
	
	add_child(obs);

func _on_timer_timeout() -> void:
	create_obstacle();
