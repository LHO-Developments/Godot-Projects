extends Node2D
class_name Spawner;

signal on_obstacle_crash;

const OBSTACLE = preload("res://Scenes/Obstacle/obstacle.tscn");
@onready var timer: Timer = $Timer

func create_obstacle() -> void:
	var obs = OBSTACLE.instantiate();
	obs.on_plane_crash.connect(_on_plane_crash);
	
	var viewport: Rect2 = get_viewport_rect();
	obs.position.x = viewport.end.x + 150;
	
	var half = viewport.size.y / 2;
	obs.position.y = randf_range(half + 240, half - 50);
	
	add_child(obs);

func stop_obstacles() -> void:
	timer.stop();
	for obs: Obstacle in get_children().filter(func(x): return x is Obstacle):
		obs.set_speed(0);

func _on_timer_timeout() -> void:
	create_obstacle();

func _on_plane_crash() -> void:
	on_obstacle_crash.emit();
	stop_obstacles();
