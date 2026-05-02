extends Control
@onready var grid_container: GridContainer = $MarginContainer/GridContainer
const HIGH_SCORE_DISPLAY = preload("uid://b7gak1nd2l2mi")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") == true:
		GameManager.load_next_level();

func set_scores() -> void:
	for score: HighScore in GameManager.high_scores.get_scores_list():
		var hsd: HighScoreDisplayItem = HIGH_SCORE_DISPLAY.instantiate();
		hsd.setup(score);
		grid_container.add_child(hsd);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false;
	set_scores();
