extends CharacterBody2D
class_name EnemyRino;

@export var ray_length := 130;
@export var move_speed := 50.0;

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D;
@onready var ray_cast_player: RayCast2D = $RayCastPlayer;
@onready var ray_cast_wall: RayCast2D = $RayCastWall

var direction: int = 1;
var can_move: bool = false;
var defeated: bool = false;

func _ready() -> void:
	ray_cast_player.target_position.x = -ray_length;

func _process(delta: float) -> void:
	if defeated:
		velocity = Vector2.ZERO;
		return;
	
	if ray_cast_player.is_colliding():
		can_move = true;
	
	if can_move:
		velocity.x = direction * move_speed;
		anim_sprite.play("run");
		move_and_slide();
	
	if ray_cast_wall.is_colliding():
		can_move = false;
		direction *= -1;
		anim_sprite.play("wall");
		await get_tree().create_timer(0.8).timeout;
		rotate_rino();
		anim_sprite.play("idle");

func rotate_rino() -> void:
	anim_sprite.scale.x = direction;
	ray_cast_player.scale.x = direction;
	ray_cast_wall.scale.x = direction;
	


func _on_top_area_body_entered(body: Node2D) -> void:
	if body is not Player: return;
	defeated = true;
	anim_sprite.play("hit");
	SoundManager.play_hit();
	await get_tree().create_timer(1.2).timeout;
	queue_free();
	


func _on_bottom_area_body_entered(body: Node2D) -> void:
	if defeated: return;
	
	SoundManager.play_hit();
	EventManager.on_player_dead.emit();
