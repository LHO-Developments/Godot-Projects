extends Area2D

@export var speed: float = 120.0;

@onready var nav_agent: NavigationAgent2D = $NavAgent;

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("set_target"):
		nav_agent.target_position = get_global_mouse_position();

func _physics_process(delta: float) -> void:
	if nav_agent.is_navigation_finished(): return
	
	var npp: Vector2 = nav_agent.get_next_path_position();
	var dir: Vector2 = global_position.direction_to(npp);
	position += dir * speed * delta;
	rotation = dir.angle();
