extends Node2D
const ENEMY_BULLET = preload("uid://cie6injvdxke4")
const PLAYER_BULLET = preload("uid://2cvw461i0ncv")

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("test") == true:
		var b = PLAYER_BULLET.instantiate();
		add_child(b);

func _ready() -> void:
	get_tree().paused = false;
