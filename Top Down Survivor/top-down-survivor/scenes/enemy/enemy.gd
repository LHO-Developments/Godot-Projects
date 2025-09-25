extends CharacterBody2D
class_name Enemy;

@export var move_speed := 400.0;
@onready var anim_sprite: AnimatedSprite2D = $AnimSprite
var can_move := true;

func _physics_process(delta: float) -> void:
	var player_dir = GameManager.player.global_position - global_position;
	var direction = player_dir.normalized();
	var movement = direction * move_speed;
	velocity = movement;
	if player_dir.length() <= 170:
		return;
	
	if not can_move:
		return;
		
	
	move_and_slide();
	anim_sprite.flip_h = true if velocity.x < 0 else false;
	
