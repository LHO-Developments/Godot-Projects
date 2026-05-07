extends NinePatchRect
class_name LevelButton;

@onready var level_label: Label = $LevelLabel;
var _level_number = "99";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = _level_number;

func setup(ln: String) -> void:
	_level_number = ln;


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		GameManager.load_level_scene(_level_number);
