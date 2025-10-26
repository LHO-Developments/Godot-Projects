extends CharacterBody2D
class_name Enemy;

@export var move_speed := 400.0;
@onready var anim_sprite: AnimatedSprite2D = $AnimSprite;
var can_move := true;

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D;
@onready var health_component: HealthComponent = $HealthComponent;

func _physics_process(delta: float) -> void:
	var player_dir = GameManager.player.global_position - global_position;
	var direction = player_dir.normalized();
	var movement = direction * move_speed;
	velocity = movement;
	if player_dir.length() <= 150:
		return;
	
	if not can_move:
		return;
		
	
	move_and_slide();
	anim_sprite.flip_h = true if velocity.x < 0 else false;
	


func _on_health_component_on_damaged() -> void:
	anim_sprite.material = GameManager.HIT_MATERIAL;
	await  get_tree().create_timer(0.3).timeout;
	anim_sprite.material = null;


func _on_health_component_on_defeated() -> void:
	can_move = false;
	
	if(anim_sprite.sprite_frames.get_frame_count('death') <= 0):
		collision_shape_2d.set_deferred('disabled', true);
	else:
			anim_sprite.play('death');
			collision_shape_2d.set_deferred('disabled', true);
			await anim_sprite.animation_finished;
	
	GameManager.create_coin(global_position);
	GameManager.on_enemy_died.emit();
	queue_free();


func _on_area_2d_body_entered(body: Node2D) -> void:
	var player = body as Player;
	player.health_component.take_damage(2);
	GameManager.play_damage_text(player.global_position, 2);
