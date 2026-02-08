extends Control
class_name GameUI;

@export var _max_attempts: int = 3;
var _attempts: int = -1;
@onready var vb_game_over: VBoxContainer = $MarginContainer/VBGameOver


@onready var attempt_label: Label = $MarginContainer/VBoxContainer/AttemptLabel
@onready var music: AudioStreamPlayer = $Music
@onready var level_label: Label = $MarginContainer/VBoxContainer/LevelLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = "Level %s" % ScoreManager.level_selected;
	update_attempts();

func _enter_tree() -> void:
		SignalHub.on_attempt_made.connect(update_attempts);
		SignalHub.on_cup_destroyed.connect(on_cup_destroyed);

func update_attempts() -> void:
	_attempts += 1;
	attempt_label.text = "Attempts: %s" % _attempts; 
	#if _max_attempts == _attempts:
		#on_cup_destroyed(0);

func on_cup_destroyed(remaining_cups: int) -> void:
	if remaining_cups == 0:
		vb_game_over.show();
		music.play();
		ScoreManager.set_score_for_level(
			ScoreManager.level_selected,
			_attempts
		);
