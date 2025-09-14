extends CharacterBody2D
class_name Player;

@export var move_speed := 700.0;
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

var can_move: bool = true;
var mouse_pos: Vector2;

func _process(delta: float) -> void:
	if not can_move: return;
	get_mouse_pos();
	update_animations();
	update_rotation();

func _physics_process(delta: float) -> void:
	if not can_move: return;
	var input := Input.get_vector("move_left","move_right","move_up","move_down");
	var direction := input.normalized();
	var movement := direction * move_speed;
	velocity = movement;
	move_and_slide();

func get_mouse_pos() -> void:
	mouse_pos = get_global_mouse_position();

func update_rotation() -> void:
	if mouse_pos.x > global_position.x:
		anim_sprite.flip_h = false;
	else:
		anim_sprite.flip_h = true;

func update_animations() -> void:
	if velocity.length() > 0:
		anim_sprite.play("move");
	else:
		anim_sprite.play("idle");
