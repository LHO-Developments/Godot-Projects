extends Area2D
class_name Checkpoint;

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return;
	anim_sprite.play("reached");
	
	EventManager.on_checkpoint_reached.emit();
