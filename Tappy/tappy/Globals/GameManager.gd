extends Node

const MAIN = preload("res://Scenes/Main/Main.tscn");
const GAME = preload("res://Scenes/Game/game.tscn");
const SIMPLE_CHANGE = preload("res://Scenes/Changes/SimpleChange.tscn")
var next_scene: PackedScene;

func change_to_next() -> void:
	if next_scene:
		get_tree().change_scene_to_packed(next_scene);

func load_main_scene() -> void:
	next_scene = MAIN;
	get_tree().change_scene_to_packed(SIMPLE_CHANGE);

func load_game_scene() -> void:
	next_scene = GAME;
	get_tree().change_scene_to_packed(SIMPLE_CHANGE);
