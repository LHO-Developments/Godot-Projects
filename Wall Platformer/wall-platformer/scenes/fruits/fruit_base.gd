extends Area2D
class_name Fruit;

var collected: bool = false;
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	if body is not Player: return;
	if collected: return;
	
	collected = true;
	anim_sprite.play("collected");
	SoundManager.play_fruit();
	EventManager.on_fruit_collected.emit();
	await  get_tree().create_timer(0.5).timeout;
	queue_free();
