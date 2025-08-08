extends CanvasLayer
class_name GameUI;

@onready var coffee_panel: UpgradePanel = $CoffeePanel
@onready var burger_panel: UpgradePanel = $BurgerPanel
@onready var current_coins: Label = %CurrentCoins

func _ready() -> void:
	coffee_panel.init_upgrade_panel(GameManager.ITEM_COFFEE);
	burger_panel.init_upgrade_panel(GameManager.ITEM_BURGER);


func _on_coffee_button_pressed() -> void:
	SoundManager.play_ui();
	coffee_panel.visible = true if not coffee_panel.visible else false;
	burger_panel.hide();
	

func _process(delta: float) -> void:
	current_coins.text = str(GameManager.current_coins);

func _on_burger_button_pressed() -> void:
	SoundManager.play_ui();
	burger_panel.visible = true if not burger_panel.visible else false;
	coffee_panel.hide();
