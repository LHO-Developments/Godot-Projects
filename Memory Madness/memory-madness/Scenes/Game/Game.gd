extends Control

const MEMORY_TILE = preload("uid://cql5xay1b52lu")
@onready var grid_container: GridContainer = $HB/GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_level_selected.connect(_on_level_selected);


func _on_level_selected(level_setting: LevelSetting) -> void:
	grid_container.columns = level_setting.cols;
	for n in level_setting.total_tiles:
		var tile = MEMORY_TILE.instantiate();
		grid_container.add_child(tile);


func _on_exit_button_pressed() -> void:
	for t in grid_container.get_children():
		t.queue_free();
	SignalHub.emit_on_game_exit_pressed();
