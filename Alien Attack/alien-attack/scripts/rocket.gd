extends Area2D

@export var speed = 0;

@onready var visible_notifier = $VisibleNotifier;

func _ready() -> void:
	visible_notifier.connect("screen_exited", _on_screen_exited);

func _physics_process(delta: float):
	global_position.x += speed * delta;

func _on_screen_exited():
	queue_free();
