extends Path2D

@onready var pathFollow = $PathFollow2D;
@onready var enemy = $PathFollow2D/enemy;

func _ready():
	pathFollow.set_progress_ratio(1);

func _process(delta: float) -> void:
	pathFollow.progress_ratio -= .25 * delta;
	if (pathFollow.progress <= 0):
		queue_free();
