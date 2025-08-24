extends Node2D
class_name Game;
@onready var player: Player = $Player

func _ready() -> void:
	EventManager.on_player_dead.connect(_on_player_dead);

func _on_player_dead() -> void:
	player.player_dead();
