extends Node2D
class_name Game;
@onready var player: Player = $Player
@onready var level_start_position: Marker2D = $LevelStartPosition

var points: int;

func _ready() -> void:
	EventManager.on_player_dead.connect(_on_player_dead);
	EventManager.on_fruit_collected.connect(_on_fruit_collected);

func _on_player_dead() -> void:
	player.player_dead();
	await  get_tree().create_timer(.5).timeout;
	var tween := create_tween().set_ease(Tween.EASE_IN);
	tween.tween_property(player, "global_position", level_start_position.position, 0.5);
	tween.tween_callback(player.respawn);

func _on_fruit_collected() -> void:
	points += 1;
