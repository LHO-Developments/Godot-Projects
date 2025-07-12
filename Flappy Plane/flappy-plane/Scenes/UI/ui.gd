extends CanvasLayer
class_name UI;

@onready var label: Label = %Label
@onready var start_menu: Control = %StartMenu

func _ready() -> void:
	label.text = "0";
	
func update_score(points: int) -> void:
	label.text = str(points);
