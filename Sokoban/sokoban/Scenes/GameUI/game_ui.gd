extends Control
class_name GameUi;

@onready var level_label: Label = $MC/VB/HB/LevelLabel;
@onready var moves_label: Label = $MC/VB/HB2/MovesLabel;
@onready var best_label: Label = $MC/VB/HB3/BestLabel;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ln: String = GameManager.get_level_Selected();
	level_label.text = ln;
	if GameManager.has_level_score(ln):
		best_label.text = str(GameManager.get_best_score(ln));

func set_moves_label(moves: int) -> void:
	moves_label.text = str(moves);
