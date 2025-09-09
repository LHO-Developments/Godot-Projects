extends Node2D
class_name Game;
@onready var player: Player = $Player
@onready var level_start_position: Marker2D = $LevelStartPosition
@onready var checkpoint_position: Marker2D = $CheckpointPosition

var points: int;
var checkpoint_reached: bool;

@onready var game_won: Panel = %GameWon
@onready var score_label: Label = %ScoreLabel

func _ready() -> void:
	EventManager.on_player_dead.connect(_on_player_dead);
	EventManager.on_fruit_collected.connect(_on_fruit_collected);
	EventManager.on_checkpoint_reached.connect(_on_checkpoint_reached);
	EventManager.on_game_won.connect(_on_game_won);
	

func get_respawn_pos() -> Vector2:
	if checkpoint_reached:
		return checkpoint_position.global_position;
	else: 
		return level_start_position.global_position;

func _on_player_dead() -> void:
	player.player_dead();
	await  get_tree().create_timer(.5).timeout;
	var tween := create_tween().set_ease(Tween.EASE_IN);
	tween.tween_property(player, "global_position", get_respawn_pos(), 0.5);
	tween.tween_callback(player.respawn);
	

func _on_fruit_collected() -> void:
	points += 1;
	score_label.text = str(points);

func _on_checkpoint_reached() -> void:
	checkpoint_reached = true;

func _on_game_won() -> void:
	game_won.show();


func _on_play_button_pressed() -> void:
	get_tree().reload_current_scene();
