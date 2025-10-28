extends Camera2D

@export var shake_decay := 0.5;
@export var shake_strength := 0.2;
@export var shake_max_roll := 0.3;

var trauma: float;
var can_shake: bool;

func _ready() -> void:
	GameManager.on_shake_request.connect(_on_shake_request);
	

func _process(delta: float) -> void:
	if can_shake:
		trauma = max(trauma - shake_max_roll * delta, 0.0);
		shake_camera();

func _on_shake_request() -> void:
	trauma = shake_strength;
	can_shake = true;

func shake_camera() -> void:
	var amount := trauma;
	rotation = shake_max_roll * amount * randf_range(-1,1);
	offset.x = 50 * amount * randf_range(-1, 1);
	offset.y = 50 * amount * randf_range(-1, 1);
