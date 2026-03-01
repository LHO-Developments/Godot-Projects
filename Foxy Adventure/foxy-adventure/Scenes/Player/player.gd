extends CharacterBody2D
class_name Player;

@onready var player: CharacterBody2D = $"."
const _GRAVITY: float = 690.0;
const  _JUMP_SPEED: float = -270;
const _RUN_SPEED: float = 200;
const _MAX_FALL: float = 350;

@export var _fell_off_y: float = 800.0;

@onready var sprite_2d: Sprite2D = $Sprite2D;
@onready var debug_label: Label = $DebugLabel;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	player.velocity.y += _GRAVITY * delta;
	
	if Input.is_action_pressed("jump") && player.is_on_floor():
		player.velocity.y = _JUMP_SPEED;
	
	player.velocity.x = _RUN_SPEED * Input.get_axis("left","right");
	if not is_equal_approx(player.velocity.x,0.0):
		sprite_2d.flip_h = player.velocity.x < 0;
	
	player.velocity.y = clampf(player.velocity.y, _JUMP_SPEED, _MAX_FALL);
	move_and_slide();
	
	update_debug_label();
	
	fallen_off();
	

func update_debug_label() -> void:
	var ds: String = "";
	ds += "Floor:%s\n" % [player.is_on_floor()];
	ds += "V:%.1f,%.1f\n" % [player.velocity.x, player.velocity.y];
	ds += "P:%.1f,%.1f\n" % [player.global_position.x, player.global_position.y];
	debug_label.text = ds;

func fallen_off() -> void:
	if player.global_position.y > _fell_off_y:
		queue_free(); 
