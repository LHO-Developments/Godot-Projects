extends Node2D
class_name Customer;

@onready var body: Sprite2D = %Body;
@onready var face: Sprite2D = %Face;
@onready var hand_left: Sprite2D = %HandLeft;
@onready var hand_right: Sprite2D = %HandRight;
@onready var anim_player: AnimationPlayer = $AnimationPlayer;

@onready var item_box: Control = $ItemBox;
@onready var item_img: TextureRect = %ItemIMG;
@onready var item_label: Label = %ItemLabel;


var request_item: Item;
var request_quantity: int;
var current_order_status: int;

var counter_pos: Vector2;
var waiting_order: bool;
var being_served: bool;

func init_customer(item: Item, quantity: int) -> void:
	request_item = item;
	request_quantity = quantity;
	current_order_status = quantity;
	

func move_to_counter() -> void:
	play_move_anim();
	var tween: Tween = create_tween();
	tween.tween_property(
		self,
		"position",
		Vector2(counter_pos.x, position.y),
		1.0
	);
	tween.tween_interval(0.2);
	tween.tween_property(
		self,
		"position",
		counter_pos,
		1.0);
	tween.tween_interval(0.5);
	tween.finished.connect(func(): 
		waiting_order = true;
		anim_player.play("Idle")
		GameManager.on_customer_request.emit(self);
	);
	

func set_sprites(data: CustomerData) -> void:
	body.texture = data.body;
	face.texture = data.face;
	hand_left.texture = data.hand;
	hand_right.texture = data.hand;
	

func show_order_ui() -> void:
	item_box.show();
	item_img.texture = request_item.sprite;
	item_label.text = str(request_quantity);
	
	

func play_move_anim() -> void:
	anim_player.play("Move");
