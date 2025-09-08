extends CharacterBody2D
class_name EnemyPig;

@export var move_speed := 70;
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast: RayCast2D = $RayCast2D

var direction: int = 1;
var can_move: bool = true;
var defeated: bool = true;

func _process(delta:float) -> void:
	if can_move:
		velocity.x = direction * move_speed;
		move_and_slide();
		
	if not ray_cast.is_colliding():
		direction *= -1;
		anim_sprite.scale.x = direction;
		ray_cast.scale.x = direction;


func _on_top_area_body_entered(body: Node2D) -> void:
	defeated = true;
	can_move = false;
	anim_sprite.play("hit");
	await get_tree().create_timer(0.8).timeout;
	queue_free();
	


func _on_bottom_area_body_entered(body: Node2D) -> void:
	if defeated: return;
	EventManager.on_player_dead.emit();
