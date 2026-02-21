extends PanelContainer
@onready var moves_label: Label = $VBoxContainer/MovesLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_game_over.connect(update_moves_label);
	SignalHub.on_game_exit_pressed.connect(on_game_exit_pressed);

func update_moves_label(moves_taken: int) -> void:
	show();
	moves_label.text = "Moves Taken: %d" % [moves_taken];

func on_game_exit_pressed() -> void:
	hide();
