extends Node

signal on_spawn_new_cashier;
signal on_customer_request(customer: Customer);
signal on_customer_order_completed(customer: Customer);

@export var item_coffee: Item;
@export var item_burger: Item;

const COIN_VFX = preload("res://Scenes/vfx/coin_vfx.tscn");

var coffee_item_counter_pos := Vector2(415,1250);
var burger_item_counter_pos := Vector2(665,1250);

var current_coins: int = 10000000;

func play_coin_vfx(spawn_pos: Vector2) -> void:
	var instance: GPUParticles2D = COIN_VFX.instantiate();
	get_tree().root.add_child(instance);
	SoundManager.play_coin();
	var new_position := Vector2(spawn_pos.x, spawn_pos.y - 60);
	instance.global_position = new_position;
	instance.emitting = true;
	instance.finished.connect(func(): instance.queue_free()); 

func get_random_item() -> Item:
	var items: Array = [item_burger, item_coffee];
	return items.pick_random();
	
	
func get_item_counter_pos(item: Item) -> Vector2:
	match item.type:
		item.ItemType.Coffee:
			return coffee_item_counter_pos
		item.ItemType.Burger:
			return burger_item_counter_pos
	return Vector2.ZERO;

func format_coins(amount: int) -> String:
	var suffixes: Array[String] =  ["","K","M","B","T"];
	var index: int = 0;
	var display_amount := float(amount);
	
	while display_amount >= 1000 and index < suffixes.size() - 1:
		display_amount = display_amount / 1000;
		index += 1;
	print(str(round_to_one_decimal(display_amount)) + suffixes[index]);
	return str(round_to_one_decimal(display_amount)) + suffixes[index];

func round_to_one_decimal(value: float) -> float:
	return floor(value * 10 + 0.5) / 10;
