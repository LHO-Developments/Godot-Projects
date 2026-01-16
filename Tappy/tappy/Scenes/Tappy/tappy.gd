extends CharacterBody2D
class_name  Tappy;

#signal on_plane_died;

const JUMP_POWER: float = -350.0;
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var _gravity: float = ProjectSettings.get("physics/2d/default_gravity");
var _jumped: bool = false;
@onready var animation_player: AnimationPlayer = $AnimationPlayer;

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("power"):
		_jumped = true;

func _physics_process(delta: float) -> void:
	
	fly(delta);
	move_and_slide();
	
	if is_on_floor():
		die();

func fly(delta: float) -> void:
	velocity.y += _gravity * delta;
	
	if _jumped:
		velocity.y = JUMP_POWER;
		animation_player.play("thrust");
		_jumped = false;

func die() -> void:
	SignalHub.emit_on_plane_died();
	get_tree().paused = true;
