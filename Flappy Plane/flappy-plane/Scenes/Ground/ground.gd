extends Node2D
class_name Ground;

signal on_player_crashed;

@onready var ground_1: Area2D = $Ground_1;
# this is when making the child sprite unique
@onready var sprite_2d: Sprite2D = %Sprite2D;

@onready var ground_2: Area2D = $Ground_2;
@export var speed: float = -150;

var width: int;

@onready var game_over_sound: AudioStreamPlayer = $GameOverSound


func _ready() -> void:
	width = sprite_2d.texture.get_width();
	

func _process(delta: float) -> void:
	
	# movement to the left for the ground objs
	ground_1.global_position.x += speed * delta;
	ground_2.global_position.x += speed * delta;
	
	# reposition where the ground is and make a infinite loop for ground_1 and ground_2
	if ground_1.global_position.x < -width / 2:
		ground_1.global_position.x = ground_2.global_position.x + width;
		
	if ground_2.global_position.x < -width / 2:
		ground_2.global_position.x = ground_1.global_position.x + width;


func _on_ground_body_entered(body: Node2D) -> void:
	on_player_crashed.emit();
	speed = 0;
	game_over_sound.play();
	var player_ref = body as Player;
	player_ref.stop_gravity();
	player_ref.stop_movement();
