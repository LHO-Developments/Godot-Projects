extends Node

signal on_customer_request(customer: Customer);

const ITEM_BURGER = preload("res://data/item_burger.tres")
const ITEM_COFFEE = preload("res://data/item_coffee.tres")

var coffee_item_counter_pos := Vector2(415,1250);
var burger_item_counter_pos := Vector2(665,1250);

func get_random_item() -> Item:
	var items: Array = [ITEM_BURGER, ITEM_COFFEE];
	return items.pick_random();
	
	
func get_item_counter_pos(item: Item) -> Vector2:
	match item.type:
		item.ItemType.Coffee:
			return coffee_item_counter_pos
		item.ItemType.Burger:
			return burger_item_counter_pos
	return Vector2.ZERO;
