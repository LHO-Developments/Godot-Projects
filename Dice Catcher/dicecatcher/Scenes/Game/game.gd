extends Node2D

const DICE = preload("res://Scenes/Dice/dice.tscn");
const MARGIN: float = 80.0;
const STOPPABLE_GROUP: String = "stoppable";
@onready var spawn_timer: Timer = $Pausable/SpawnTimer;

var _points: int = 0;
@onready var score_label: Label = $ScoreLabel
const GAME_OVER = preload("res://Asset/game_over.wav");
@onready var music: AudioStreamPlayer = $Music;
@onready var pausable: Node = $Pausable;

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene();

func _ready() -> void:
	get_tree().paused = false;
	update_score_label();
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
	pausable.add_child(new_dice);

func pause_all() -> void:
	spawn_timer.stop();
	var to_stop: Array[Node] = get_tree().get_nodes_in_group(STOPPABLE_GROUP);
	for item in to_stop:
		item.set_physics_process(false);

func update_score_label() -> void:
	score_label.text = "%04d" % _points;

func _on_dice_game_over() -> void:
	#pause_all();
	music.stop();
	music.stream = GAME_OVER;
	music.play();
	get_tree().paused = true;

func _on_spawn_timer_timeout() -> void:
	spawn_dice();

func _on_fox_score() -> void:
	_points += 1;
	update_score_label();
