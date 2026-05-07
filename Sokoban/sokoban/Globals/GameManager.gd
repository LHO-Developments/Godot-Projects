extends Node

const LEVEL = preload("uid://3erogswmru6e");
const MAIN = preload("uid://dt12mjj45tb81")

var _level_selected: String = "1";

func get_level_Selected() -> String:
	return _level_selected;

func load_level_scene(ln: String) -> void:
	_level_selected = ln;
	get_tree().change_scene_to_packed(LEVEL);

func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN);
