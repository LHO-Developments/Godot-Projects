extends CharacterBody2D
class_name Player;
signal  on_game_started;

@export var gravity: float = 1000;
@export var jump_force: float = -400;
@export var max_speed: float = 400;
@export var rotation_speed: float = 2;

var is_started: bool = false;
var should_process_input: bool = true;

func _physics_process(delta: float) -> void:
		# Check for jump input
	if Input.is_action_just_pressed("jump") && should_process_input:
		velocity.y = jump_force;
		rotation = deg_to_rad(-30);
		if !is_started:
			is_started = true;
			on_game_started.emit();
	
	if !is_started:
		return ;
		
	
	# apply gravity
	velocity.y += gravity * delta;
	velocity.y = min(velocity.y, max_speed);
	
	# move the player
	move_and_slide();
	
	# rotate the player while falling
	rotate_player(delta);

func rotate_player(delta: float) -> void:
	if velocity.y > 0 && rotation < deg_to_rad(90):
		rotation += rotation_speed * delta;
