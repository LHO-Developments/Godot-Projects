extends Node

@export var main_menu_music: AudioStream;
@export var game_music: AudioStream;
@export var click_music: AudioStream;
@export var title_music: AudioStream;
@export var game_over_music: AudioStream;

@onready var music: AudioStreamPlayer = $Music
@onready var effects: AudioStreamPlayer = $Effects

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_level_selected.connect(on_level_selected);
	SignalHub.on_tile_selected.connect(on_title_selected);
	SignalHub.on_game_over.connect(on_game_over);
	SignalHub.on_game_exit_pressed.connect(on_game_exit_pressed);
	on_game_exit_pressed()

func play_music(stream: AudioStream) -> void:
	music.stream = stream;
	music.play();

func play_effect(stream: AudioStream) -> void:
	effects.stream = stream;
	effects.play();

func on_level_selected(_level: LevelSetting) -> void:
	play_music(game_music);
	play_effect(click_music)

func on_title_selected(_title: MemoryTile) -> void:
	play_music(title_music)

func on_game_over(_moves_taken: int) -> void:
	play_effect(game_over_music)

func on_game_exit_pressed() -> void:
	play_music(main_menu_music);
