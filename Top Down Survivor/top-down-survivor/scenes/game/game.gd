extends Node2D
class_name Game;

@onready var player: Player = $Player
@onready var crosshair: Sprite2D = $Crosshair
@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	#hide mouse
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN;

func _process(delta: float) -> void:
	crosshair.global_position = get_global_mouse_position();
	camera_2d.global_position = player.global_position;
