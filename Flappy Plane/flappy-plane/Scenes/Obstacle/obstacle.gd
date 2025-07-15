extends Node2D
class_name Obstacle;
signal on_plane_crash;
signal player_scored;

@export var move_speed: float = 150;

@onready var hit_sound: AudioStreamPlayer = $HitSound
@onready var score_sound: AudioStreamPlayer = $ScoreSound

func _process(delta: float) -> void:
	position.x -= move_speed * delta;

func set_speed(value: float) -> void:
	move_speed = value;

func _on_top_body_entered(body: Node2D) -> void:
	if not body is Player: return
	on_plane_crash.emit();
	hit_sound.play();


func _on_bottom_body_entered(body: Node2D) -> void:
	if not body is Player: return
	on_plane_crash.emit();
	hit_sound.play();


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free();


func _on_score_body_entered(body: Node2D) -> void:
	player_scored.emit();
	score_sound.play();
