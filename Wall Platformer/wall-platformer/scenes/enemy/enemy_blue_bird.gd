extends CharacterBody2D
class_name EnemyBlueBird;

@export var path: CustomPathFollow;
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D;

var deafeated: bool = false;

func _process(delta: float) -> void:
	anim_sprite.flip_h = path.direction == 1;


func _on_top_area_body_entered(body: Node2D) -> void:
	if body is not Player:
		return;
	deafeated = true;
	path.can_move = false;
	anim_sprite.play("hit");
	SoundManager.play_hit();
	body.velocity.y = -250;
	await get_tree().create_timer(0.4).timeout;
	queue_free();


func _on_bottom_area_body_entered(body: Node2D) -> void:
	if body is not Player:
		return;
	if deafeated:
		return;
	
	SoundManager.play_hit();
	EventManager.on_player_dead.emit();
