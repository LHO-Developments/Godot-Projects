extends Control

@onready var main: Control = $Main
@onready var game: Control = $Game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_level_selected.connect(_on_level_selected);
	SignalHub.on_game_exit_pressed.connect(on_game_exit_pressed);
	on_game_exit_pressed()


func _on_level_selected(level_setting: LevelSetting) -> void:
	show_game(true);

func show_game(show: bool) -> void:
	if show:
		main.hide();
		game.show();
	else:
		main.show();
		game.hide();
	
func on_game_exit_pressed() -> void:
	show_game(false);
