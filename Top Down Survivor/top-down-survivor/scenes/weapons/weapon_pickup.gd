extends Area2D
class_name WeaponPickup;

@export var weapon_data: WeaponData;
@onready var weapon_spriite: Sprite2D = $WeaponSpriite
@onready var buy_label: Label = $BuyLabel
@onready var price_label: Label = %PriceLabel
@onready var pickup: AudioStreamPlayer = $Pickup

var can_interact: bool;

func _ready() -> void:
	set_weapon();

func set_weapon() -> void:
	weapon_spriite.texture = weapon_data.gun_sprite;
	weapon_spriite.modulate = weapon_data.gun_color;
	price_label.text = str(weapon_data.buy_price);

func _input(event: InputEvent) -> void:
	if can_interact and event.is_action_pressed("interact"):
		if GameManager.coins >= weapon_data.buy_price:
			pickup.play();
			GameManager.remove_coins(weapon_data.buy_price);
			GameManager.player.setup_weapon(weapon_data);
		
		

func _on_body_entered(body: Node2D) -> void:
	buy_label.show();
	can_interact = true;


func _on_body_exited(body: Node2D) -> void:
	buy_label.hide();
	can_interact = false;
