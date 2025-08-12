extends CanvasLayer
class_name GameUI;

@export var cashier_1_cost := 50;
@export var cashier_2_cost := 500;
@export var cashier_3_cost := 5000;

@export var faster_coffee_cost := 250;
@export var faster_burger_cost := 1500;

@onready var coffee_panel: UpgradePanel = $CoffeePanel
@onready var burger_panel: UpgradePanel = $BurgerPanel
@onready var current_coins: Label = %CurrentCoins

@onready var new_cashier_card: Panel = %NewCashierCard
@onready var faster_coffee_card: Panel = %FasterCoffeeCard
@onready var new_cashier_card_2: Panel = %NewCashierCard2
@onready var faster_burger_card: Panel = %FasterBurgerCard
@onready var new_cashier_card_3: Panel = %NewCashierCard3


@onready var new_cashier_1: Button = %NewCashier1
@onready var faster_coffee: Button = %FasterCoffee
@onready var new_cashier_2: Button = %NewCashier2
@onready var faster_burger: Button = %FasterBurger
@onready var new_cashier_3: Button = %NewCashier3

@onready var shop: Control = $Shop

func _ready() -> void:
	coffee_panel.init_upgrade_panel(GameManager.item_coffee);
	burger_panel.init_upgrade_panel(GameManager.item_burger);
	new_cashier_1.text = str(cashier_1_cost);
	new_cashier_2.text = str(cashier_2_cost);
	new_cashier_3.text = str(cashier_3_cost);
	faster_coffee.text = str(faster_coffee_cost);
	faster_burger.text = str(faster_burger_cost);

func _process(delta: float) -> void:
	current_coins.text = str(GameManager.current_coins);
	

func show_hide_shop_panel() -> void:
	shop.visible = true if not shop.visible else false;

func _on_coffee_button_pressed() -> void:
	SoundManager.play_ui();
	coffee_panel.visible = true if not coffee_panel.visible else false;
	burger_panel.hide();
	

func _on_burger_button_pressed() -> void:
	SoundManager.play_ui();
	burger_panel.visible = true if not burger_panel.visible else false;
	coffee_panel.hide();


func _on_new_cashier_1_pressed() -> void:
	SoundManager.play_ui();
	if GameManager.current_coins >= cashier_1_cost:
		GameManager.current_coins -= cashier_1_cost;
		GameManager.on_spawn_new_cashier.emit();
		new_cashier_card.hide();

func _on_new_cashier_2_pressed() -> void:
	SoundManager.play_ui();
	if GameManager.current_coins >= cashier_2_cost:
		GameManager.current_coins -= cashier_2_cost;
		GameManager.on_spawn_new_cashier.emit();
		new_cashier_card_2.hide();

func _on_new_cashier_3_pressed() -> void:
	SoundManager.play_ui();
	if GameManager.current_coins >= cashier_3_cost:
		GameManager.current_coins -= cashier_3_cost;
		GameManager.on_spawn_new_cashier.emit();
		new_cashier_card_3.hide();


func _on_faster_coffee_pressed() -> void:
	SoundManager.play_ui();
	if GameManager.current_coins >= faster_coffee_cost:
		GameManager.current_coins -= faster_coffee_cost;
		GameManager.item_coffee.cook_time = 1;
		faster_coffee_card.hide();
	
	
func _on_faster_burger_pressed() -> void:
	SoundManager.play_ui();
	if GameManager.current_coins >= faster_burger_cost:
		GameManager.current_coins -= faster_burger_cost;
		GameManager.item_burger.cook_time = 1;
		faster_burger_card.hide();


func _on_shop_button_pressed() -> void:
	show_hide_shop_panel();
