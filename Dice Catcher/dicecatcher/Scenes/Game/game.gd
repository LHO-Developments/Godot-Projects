extends Node2D

const DICE = preload("res://Scenes/Dice/dice.tscn");
const MARGIN: float = 80.0;
const STOPPABLE_GROUP: String = "stoppable";
@onready var spawn_timer: Timer = $SpawnTimer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene();

func _ready() -> void:
	spawn_dice();
	

func spawn_dice() -> void:
	var new_dice: Dice = DICE.instantiate();
	var vpr: Rect2 = get_viewport_rect();
	var new_x: float = randf_range(
		vpr.position.x + MARGIN,
		vpr.end.x - MARGIN
	)
	new_dice.position = Vector2(new_x, -MARGIN);
	new_dice.game_over.connect(_on_dice_game_over);
	add_child(new_dice);

func pause_all() -> void:
	spawn_timer.stop();
	var to_stop: Array[Node] = get_tree().get_nodes_in_group(STOPPABLE_GROUP);
	for item in to_stop:
		item.set_physics_process(false);

func _on_dice_game_over() -> void:
	pause_all();


func _on_spawn_timer_timeout() -> void:
	spawn_dice();

func _on_fox_score() -> void:
	print("SCORED")
