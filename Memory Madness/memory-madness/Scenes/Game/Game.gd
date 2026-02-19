extends Control

const MEMORY_TILE = preload("uid://cql5xay1b52lu")
@onready var grid_container: GridContainer = $HB/GridContainer
@onready var scorer: Scorer = $Scorer;
@onready var pairs_label: Label = $HB/VB/HB2/PairsLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_level_selected.connect(_on_level_selected);

func _process(delta: float) -> void:
	pairs_label.text = scorer.get_pairs_str();

func _on_level_selected(level_setting: LevelSetting) -> void:
	
	var lds: LevelDataSelector = LevelDataSelector.new();
	var selected_images: Array[Texture2D] = lds.get_images_for_level(level_setting);
	var frame_image: Texture2D = ImageManager.get_random_frame_image();
	
	grid_container.columns = level_setting.cols;
	for image in selected_images:
		var tile: MemoryTile = MEMORY_TILE.instantiate();
		grid_container.add_child(tile);
		tile.setup(image,frame_image);
		
	scorer.clear_new_game();


func _on_exit_button_pressed() -> void:
	for t in grid_container.get_children():
		t.queue_free();
	SignalHub.emit_on_game_exit_pressed();
