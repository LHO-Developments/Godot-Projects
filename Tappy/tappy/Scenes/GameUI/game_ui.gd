extends Control;

class_name GameUi;

@onready var press_space_label: Label = $MarginContainer/PressSpaceLabel;
@onready var game_over_label: Label = $MarginContainer/GameOverLabel;
@onready var sound: AudioStreamPlayer = $Sound;
@onready var timer: Timer = $Timer;

@onready var score_label: Label = $MarginContainer/ScoreLabel
var _points: int = 0;


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		GameManager.load_main_scene();
	if press_space_label.visible && event.is_action_pressed("power"):
		GameManager.load_main_scene();
		

func _ready() -> void:
	SignalHub.on_plane_died.connect(on_plane_died);
	SignalHub.on_point_scored.connect(on_point_scored);
	update_score_label();

func on_plane_died() -> void:
	game_over_label.show();
	sound.play();
	timer.start();
	ScoreManager.high_score = _points;


func _on_timer_timeout() -> void:
	game_over_label.hide();
	press_space_label.show();

func on_point_scored() -> void:
	_points += 1;
	update_score_label();

func update_score_label() -> void:
	score_label.text = "%03d" % _points;
