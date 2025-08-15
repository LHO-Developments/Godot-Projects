extends Control
class_name UpgradePanel

@onready var level: Label = %Level
@onready var item_name: Label = %ItemName
@onready var progress_bar: ProgressBar = %ProgressBar

@onready var profit: Label = %Profit
@onready var cook_time: Label = %CookTime
@onready var upgrade_button: Button = %UpgradeButton
@onready var star_h_box: HBoxContainer = %StarHBox

var item_ref: Item;
var current_level:  int;
var current_stars: int = -1;

func _process(delta: float) -> void:
	progress_bar.value = current_level / 25.0;

func init_upgrade_panel(item: Item) -> void:
	item_ref = item;
	item_name.text = item.id;
	progress_bar.value = 0;
	update_stats();
	item_ref.on_star_reached.connect(_on_star_reached);
	

func update_stats() -> void:
	level.text = "LV. %s" % item_ref.current_level;
	profit.text = GameManager.format_coins(item_ref.profit);
	cook_time.text = str(item_ref.cook_time);
	upgrade_button.text = GameManager.format_coins(item_ref.upgrade_cost);

func _on_star_reached() -> void:
	current_level = 0;
	current_stars += 1;
	var star: TextureRect = star_h_box.get_child(current_stars);
	star.modulate = Color(255, 255, 255);


func _on_upgrade_button_pressed() -> void:
	SoundManager.play_ui();
	if GameManager.current_coins < item_ref.upgrade_cost:
		return
	
	GameManager.current_coins -= item_ref.upgrade_cost;
	current_level += 1;
	item_ref.update_item();
	update_stats();
