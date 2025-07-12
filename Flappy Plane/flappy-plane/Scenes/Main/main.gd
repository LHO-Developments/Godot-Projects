extends Node2D
@onready var spawner: Spawner = $Spawner
@onready var player: Player = $Player
@onready var ground: Ground = $Ground


func _on_player_on_game_started() -> void:
	spawner.timer.start();


func _on_spawner_on_obstacle_crash() -> void:
	# stop player and ground once player crash obstacle
	player.stop_movement();
	ground.speed = 0;


func _on_ground_on_player_crashed() -> void:
	# when player hit ground stop obstacle
	spawner.stop_obstacles();
