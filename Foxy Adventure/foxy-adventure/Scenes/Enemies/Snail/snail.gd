extends EnemyBase
@onready var snail: CharacterBody2D = $".";

@onready var ray_cast_2d: RayCast2D = $RayCast2D;

func _physics_process(delta: float) -> void:
	super._physics_process(delta);
	snail.velocity.y += delta * _gravity;
	snail.velocity.x = speed if animated_sprite_2d.flip_h == true else -speed;
	move_and_slide();
	flip_me();
	

func flip_me() -> void:
	if is_on_wall() == true or ray_cast_2d.is_colliding() == false:
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
		ray_cast_2d.position.x = -ray_cast_2d.position.x;
