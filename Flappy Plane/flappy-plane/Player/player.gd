extends CharacterBody2D

@export var gravity: float = 1000;
@export var jump_force: float = -400;
@export var max_speed: float = 400;
@export var rotation_speed: float = 2;

func _physics_process(delta: float) -> void:
	
	# apply gravity
	velocity.y += gravity * delta;
	velocity.y = min(velocity.y, max_speed);
	
	# Check for jump input
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_force;
		rotation = deg_to_rad(-30);
	
	# move the player
	move_and_slide();
	
	# rotate the player while falling
	rotate_player(delta);

func rotate_player(delta: float) -> void:
	if velocity.y > 0 && rotation < deg_to_rad(90):
		rotation += rotation_speed * delta;
