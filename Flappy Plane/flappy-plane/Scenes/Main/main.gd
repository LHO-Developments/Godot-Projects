extends Node2D

const SAVEFILE: String = "user://score.save";

@onready var spawner: Spawner = $Spawner;
@onready var player: Player = $Player;
@onready var ground: Ground = $Ground;
@onready var ui: UI = $UI;

var score: int;
var highscore: int;

@onready var bg_song: AudioStreamPlayer = $BGSong


func _ready() -> void:
	load_highscore();
	

func load_highscore() -> void:
	var file: FileAccess = FileAccess.open(SAVEFILE, FileAccess.READ);
	if file:
		highscore = file.get_32();
		

func save_score() -> void:
	if score > highscore:
		highscore = score;
		var file: FileAccess = FileAccess.open(SAVEFILE, FileAccess.WRITE);
		file.store_32(highscore);

func _on_player_on_game_started() -> void:
	bg_song.play();
	spawner.timer.start();
	ui.start_menu.hide();


func _on_spawner_on_obstacle_crash() -> void:
	# stop player and ground once player crash obstacle
	player.stop_movement();
	ground.speed = 0;


func _on_ground_on_player_crashed() -> void:
	# when player hit ground stop obstacle
	spawner.stop_obstacles();
	load_highscore();
	ui.game_over();
	ui.calculate_score(score, highscore);


func _on_spawner_on_player_scored() -> void:
	score += 1;
	ui.update_score(score);
	save_score();
