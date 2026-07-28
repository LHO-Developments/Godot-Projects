extends Area2D

enum EnemyState {Patrolling, Searching, Chasing};

@export var speed: float = 120.0;
@export var patrol_points: Node2D;

@onready var nav_agent: NavigationAgent2D = $NavAgent;

var _patrol_points: Array[Vector2];
var _state: EnemyState = EnemyState.Patrolling;
var _patrol_ix: int = 0;

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("set_target"):
		nav_agent.target_position = get_global_mouse_position();

func _ready() -> void:
	for node in patrol_points.get_children():
		if node is Marker2D: _patrol_points.append(node.global_position);
	
	if _patrol_points.size() < 2:
		queue_free();
		return;

func _physics_process(delta: float) -> void:
	process_behaviour();
	update_movement(delta);

func update_movement(delta: float) -> void:
	if nav_agent.is_navigation_finished(): return
	
	var npp: Vector2 = nav_agent.get_next_path_position();
	var dir: Vector2 = global_position.direction_to(npp);
	position += dir * speed * delta;
	rotation = dir.angle();

func navigate_to_patrol_point() -> void:
	nav_agent.target_position = _patrol_points[_patrol_ix];
	_patrol_ix = (_patrol_ix + 1) % _patrol_points.size();

func process_patroling() -> void:
	if nav_agent.is_navigation_finished():
		navigate_to_patrol_point();

func process_behaviour() -> void:
	match  _state:
		EnemyState.Patrolling:
			process_patroling();
		
