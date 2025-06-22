extends CharacterBody2D
@export var gravity = 400;
@export var speed = 125;
@export var jump_force = 200;

@onready var animated_sprite = $AnimatedSprite2D;

func _physics_process(delta: float) -> void:
	# used to handle when player is falling + cap the falling to 500
	if is_on_floor() == false:
		velocity.y += gravity * delta;
		if velocity.y > 500:
			velocity.y = 500;
			
	# used to to make player jump
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force;
		
	# used to make player move left or right
	var direction = Input.get_axis("move_left","move_right");
	velocity.x = direction * speed;
	
	move_and_slide();
