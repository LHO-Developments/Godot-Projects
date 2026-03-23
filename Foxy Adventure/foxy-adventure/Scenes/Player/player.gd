extends CharacterBody2D
class_name Player;

const JUMP = preload("uid://gb2linuqnrcm")
const DAMAGE = preload("uid://wobe8vtsqnm0")
@onready var hurt_timer: Timer = $HurtTimer

@onready var player: CharacterBody2D = $"."
const _GRAVITY: float = 690.0;
const  _JUMP_SPEED: float = -270;
const _RUN_SPEED: float = 200;
const _MAX_FALL: float = 350;
const _HURT_JUMP_VELOCITY: Vector2 = Vector2(0,-130.0);


@export var _fell_off_y: float = 800.0;

@onready var sprite_2d: Sprite2D = $Sprite2D;
@onready var debug_label: Label = $DebugLabel;

@onready var shooter: Shooter = $Shooter;
@onready var sound: AudioStreamPlayer2D = $Sound

var _is_hurt: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") == true:
		var dir: Vector2 = Vector2.LEFT if sprite_2d.flip_h else Vector2.RIGHT;
		shooter.shoot(dir);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	player.velocity.y += _GRAVITY * delta;
	
	get_input();
	
	player.velocity.y = clampf(player.velocity.y, _JUMP_SPEED, _MAX_FALL);
	move_and_slide();
	
	update_debug_label();
	
	fallen_off();

func play_effect(effect: AudioStream) -> void:
	sound.stop();
	sound.stream = effect;
	sound.play();

func get_input() -> void:
	
	if _is_hurt == true:
		return;
	
	if Input.is_action_pressed("jump") && player.is_on_floor():
		player.velocity.y = _JUMP_SPEED;
		play_effect(JUMP);
	
	player.velocity.x = _RUN_SPEED * Input.get_axis("left","right");
	if not is_equal_approx(player.velocity.x,0.0):
		sprite_2d.flip_h = player.velocity.x < 0;
	

func update_debug_label() -> void:
	var ds: String = "";
	ds += "Floor:%s\n" % [player.is_on_floor()];
	ds += "V:%.1f,%.1f\n" % [player.velocity.x, player.velocity.y];
	ds += "P:%.1f,%.1f\n" % [player.global_position.x, player.global_position.y];
	debug_label.text = ds;

func fallen_off() -> void:
	if player.global_position.y > _fell_off_y:
		queue_free(); 

func apply_hurt_jump() -> void:
	_is_hurt = true;
	velocity = _HURT_JUMP_VELOCITY;
	hurt_timer.start();
	play_effect(DAMAGE);

func apply_hit() -> void:
	apply_hurt_jump();

func _on_hit_box_area_entered(area: Area2D) -> void:
	call_deferred("apply_hit");


func _on_hurt_timer_timeout() -> void:
	_is_hurt = false;
