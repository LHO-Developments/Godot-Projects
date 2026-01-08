extends Node2D
class_name  Pipes;

const SPEED: float = 120.0;
@onready var life_timer: Timer = $LifeTimer;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta;


func _on_screen_notifier_screen_exited() -> void:
	queue_free();


func _on_life_timer_timeout() -> void:
	queue_free();
