extends Node

signal on_enemy_died;

const EXPLOSION_ANIM = preload("res://scenes/extra/explosion_anim.tscn")
var player: Player;

func play_explosion_anim(pos: Vector2) -> void:
	var anim: AnimatedSprite2D = EXPLOSION_ANIM.instantiate();
	anim.global_position = pos;
	anim.z_index = 99;
	get_parent().add_child(anim);
	await anim.animation_finished;
	anim.queue_free();
