extends CharacterBody2D
class_name Player;

@onready var player: CharacterBody2D = $"."
const _GRAVITY: float = PhysicsServer2D.AREA_PARAM_GRAVITY;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	player.velocity.y += _GRAVITY + delta;
	move_and_slide();

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") && player.is_on_floor():
		player.velocity.y -= 50;
