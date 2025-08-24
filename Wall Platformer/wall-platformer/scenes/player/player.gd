extends CharacterBody2D
class_name Player;

# default player var input
@export var max_speed: float = 180;
@export var jump_force: float = 450;
@export var max_jumps: int = 2;
@export var gravity: float = 1600;

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

var jumps_left: int;
var move_direction: int = 1;
var can_move: bool = true;

func _ready() -> void:
	jumps_left = max_jumps;

func _physics_process(delta: float) -> void:
	if not can_move:
		return
	
	# handle move the character
	handle_movement();
	
	#  handle the gravity of character
	handle_gravity(delta);
	
	# handle wall collisionwith character
	handle_wall_collision();
	
	# handle the jump movement of character
	handle_jump_input();
	
	# handle move and slide when updating velocity
	move_and_slide();

func handle_movement() -> void:
	velocity.x = move_direction * max_speed;
	if is_on_floor():
		anim_sprite.play("run");
		jumps_left = max_jumps;

func handle_gravity(delta: float) -> void:
	if  not is_on_floor():
		velocity.y += gravity * delta;

func handle_wall_collision() -> void:
	if not ray_cast_2d.is_colliding():
		return;
	
	velocity.y = 50;
	jumps_left = max_jumps;
	anim_sprite.play("fall");
	
	if is_on_floor():
		change_direction();
	

func change_direction() -> void:
	move_direction *= -1;
	scale.x *= -1;
	

func handle_jump_input() -> void:
	if not Input.is_action_just_pressed("tap"):
		return;
	if ray_cast_2d.is_colliding():
		change_direction();
		jump();
	else:
		jump();

func jump() -> void:
	if jumps_left <= 0:
		return;
	velocity.y = -jump_force;
	jumps_left -= 1;
	if jumps_left <= 0:
		anim_sprite.play("double_jump");
	else:
		anim_sprite.play("jump");
		

func player_dead() -> void:
	can_move = false;
	velocity = Vector2.ZERO;
	anim_sprite.play("dead");
