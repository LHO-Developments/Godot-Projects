extends Control

const LEVELS_COUNT: int = 30;
@onready var grid_container: GridContainer = $MC/VB/GridContainer;
const LEVEL_BUTTON = preload("uid://de5mer8j0p27v");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_grid();

func setup_grid() -> void:
	for level in range(LEVELS_COUNT):
		var lb: LevelButton = LEVEL_BUTTON.instantiate();
		lb.setup(str(level+1));
		grid_container.add_child(lb);
