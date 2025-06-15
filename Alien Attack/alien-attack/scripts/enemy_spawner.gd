extends Node2D

signal enemy_spawned(enemy_instance);

var enemy_scene = preload("res://scenes/enemy.tscn");

@onready var spawn_positions = $SpawnPositions;

func _on_timer_timeout() -> void:
	spawn_enemy();

func spawn_enemy() -> void:
	# get an array of children of enemy markers
	var spawn_position_array = spawn_positions.get_children();
	
	# pick random marker to spawn the enemy
	var random_spawn_position = spawn_position_array.pick_random();
	
	# create instance of enemy obj
	var enemy_instance = enemy_scene.instantiate();
	enemy_instance.global_position = random_spawn_position.global_position;
	emit_signal("enemy_spawned", enemy_instance);
	
