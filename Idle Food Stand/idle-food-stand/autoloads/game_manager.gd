extends Node

signal on_customer_request(customer: Customer);

const ITEM_BURGER = preload("res://data/item_burger.tres")
const ITEM_COFFEE = preload("res://data/item_coffee.tres")

func get_random_item() -> Item:
	var items: Array = [ITEM_BURGER, ITEM_COFFEE];
	return items.pick_random();
	
