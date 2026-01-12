extends Node

const MAIN = preload("res://Scenes/Main/Main.tscn");
const GAME = preload("res://Scenes/Game/game.tscn");

func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN);

func load_game_scene() -> void:
	get_tree().change_scene_to_packed(GAME);
