extends Control;

class_name GameUi;

@onready var press_space_label: Label = $MarginContainer/PressSpaceLabel;
@onready var game_over_label: Label = $MarginContainer/GameOverLabel;
@onready var sound: AudioStreamPlayer = $Sound;
@onready var timer: Timer = $Timer;


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		GameManager.load_main_scene();
	if press_space_label.visible && event.is_action_pressed("power"):
		GameManager.load_main_scene();
		

func _ready() -> void:
	SignalHub.on_plane_died.connect(on_plane_died);

func on_plane_died() -> void:
	game_over_label.show();
	sound.play();
	timer.start();


func _on_timer_timeout() -> void:
	game_over_label.hide();
	press_space_label.show();
