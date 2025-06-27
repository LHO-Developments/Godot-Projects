extends Node

@onready var start = $Start;
var player = null;

func _ready() -> void:
	
	# use group instead of referencing it similar to start var
	player = get_tree().get_first_node_in_group("player");
	if player != null:
		player.global_position = start.get_spawn_pos();
	
	var traps = get_tree().get_nodes_in_group("traps");
	for trap in traps:
		# alternative way to connect
		# trap.connect("touched_player", _on_trap_touched_player);
		trap.touched_player.connect(_on_trap_touched_player);

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("quit")):
		get_tree().quit();
	elif(Input.is_action_just_pressed("reset")):
		get_tree().reload_current_scene();


func _on_deathzone_body_entered(body: Node2D) -> void:
	reset_player();


func _on_trap_touched_player() -> void:
	reset_player();


func reset_player():
	player.velocity = Vector2.ZERO;
	player.global_position = start.get_spawn_pos();
