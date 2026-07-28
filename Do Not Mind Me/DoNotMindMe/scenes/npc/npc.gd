extends Area2D

enum EnemyState {Patrolling, Searching, Chasing};

@export var speed: float = 60.0;
@export var patrol_points: Node2D;

@onready var nav_agent: NavigationAgent2D = $NavAgent;
@onready var player_detect: RayCast2D = $PlayerDetect
@onready var label: Label = $CanvasLayer/Label;
@onready var gasp: AudioStreamPlayer2D = $Gasp;

var _patrol_points: Array[Vector2];
var _state: EnemyState = EnemyState.Patrolling;
var _patrol_ix: int = 0;
var _player_ref: Player;

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("set_target"):
		nav_agent.target_position = get_global_mouse_position();

func _ready() -> void:
	for node in patrol_points.get_children():
		if node is Marker2D: _patrol_points.append(node.global_position);
	
	if _patrol_points.size() < 2:
		queue_free();
		return;
	
	_player_ref = get_tree().get_first_node_in_group("player");
	if !_player_ref:
		queue_free();
		return;

func _physics_process(delta: float) -> void:
	detect_player();
	process_behaviour();
	update_movement(delta);
	update_raycast();
	
	label.text = "SeePL:%s\n" % can_see_player();
	label.text += "FOV:%.1f\n" % fov_angle();
	label.text += "%s" % EnemyState.keys()[_state];

func update_movement(delta: float) -> void:
	if nav_agent.is_navigation_finished(): return
	
	var npp: Vector2 = nav_agent.get_next_path_position();
	var dir: Vector2 = global_position.direction_to(npp);
	position += dir * speed * delta;
	rotation = dir.angle();

func can_see_player() -> bool:
	return player_detect.get_collider() is Player and abs(fov_angle()) < 60;

func fov_angle() -> float:
	var dir: Vector2 = global_position.direction_to(_player_ref.global_position);
	var atp: float = transform.x.angle_to(dir);
	return rad_to_deg(atp);

func detect_player() -> void:
	if can_see_player():
		change_state(EnemyState.Chasing);
	elif _state == EnemyState.Chasing:
		change_state(EnemyState.Searching);

func update_raycast() -> void:
	player_detect.look_at(_player_ref.global_position);

func navigate_to_patrol_point() -> void:
	nav_agent.target_position = _patrol_points[_patrol_ix];
	_patrol_ix = (_patrol_ix + 1) % _patrol_points.size();

func process_patroling() -> void:
	if nav_agent.is_navigation_finished():
		navigate_to_patrol_point();

func process_searching() -> void:
	if nav_agent.is_navigation_finished():
		change_state(EnemyState.Patrolling);

func process_chasing() -> void:
	nav_agent.target_position = _player_ref.global_position;

func process_behaviour() -> void:
	match  _state:
		EnemyState.Patrolling:
			process_patroling();
		EnemyState.Chasing:
			process_chasing();
		EnemyState.Searching:
			process_searching();

func change_state(new_state: EnemyState) -> void:
	if new_state == _state: return;
	_state = new_state;
	
	match  _state:
		EnemyState.Chasing:
			gasp.play();
