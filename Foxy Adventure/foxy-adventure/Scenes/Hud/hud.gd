extends Control

var _score: int = 0;
@onready var score_label: Label = $MarginContainer/ScoreLabel

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit") == true:
		GameManager.load_main();


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _enter_tree() -> void:
	SignalHub.on_score.connect(on_scored);
	

func on_scored(points: int) -> void:
	_score += points;
	score_label.text = "%05d" % _score;
