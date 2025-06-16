extends CharacterBody2D
var speed = 300;
var rocket_scene = preload("res://scenes/rocket.tscn");
signal took_damage;

# short hand on _ready() && get_node("RocketContainer");
@onready var rocket_container = $RocketContainer;

@onready var rocket_laser_sound = $RocketLaserSound;

func _process(delta: float) -> void:
	# shoot rocket
	if Input.is_action_just_pressed("shoot"):
		shoot();
	

func _physics_process(delta: float):
	velocity = Vector2(0,0);
	
	# make movement
	if Input.is_action_pressed("move_right"):
		velocity.x = speed;
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed;
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed;
	if Input.is_action_pressed("move_down"):
		velocity.y = speed;
	move_and_slide();
	
	# prevent user passing the screen
	var screen_size = get_viewport_rect().size;
	global_position = global_position.clamp(Vector2(0,0), screen_size);

# shoot rocket from ship
func shoot():
	# create instance of rocket obj
	var rocket_instance = rocket_scene.instantiate();
	
	# add rocket to player scene
	rocket_container.add_child(rocket_instance);
	
	# add rocket where the player is at
	rocket_instance.global_position = global_position;
	
	#space out the rocket when ship is being shoot
	rocket_instance.global_position.x += 80;
	
	# play sound of rocket being release
	rocket_laser_sound.play();

# called custom signal to subtract lives from game scene
func take_damage():
	emit_signal("took_damage");

# player dies
func die():
	queue_free();
