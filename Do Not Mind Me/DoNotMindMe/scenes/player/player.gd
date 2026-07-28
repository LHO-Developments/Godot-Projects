class_name Player;
extends CharacterBody2D

@export var speed: float = 200.0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var input: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	velocity = input.normalized() * speed;
	
	if !is_zero_approx(velocity.length()):
		rotation = velocity.angle();
	move_and_slide();
