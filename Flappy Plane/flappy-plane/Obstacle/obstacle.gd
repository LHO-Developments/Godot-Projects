extends Node2D

signal on_plane_crash;

@export var move_speed: float = 150;

func _process(delta: float) -> void:
	position.x -= move_speed * delta;
	

func _on_top_body_entered(body: Node2D) -> void:
	if body != Player: return
	on_plane_crash.emit();
	print("This Top");


func _on_bottom_body_entered(body: Node2D) -> void:
	if body != Player: return
	on_plane_crash.emit();
	print("This Bottom");
