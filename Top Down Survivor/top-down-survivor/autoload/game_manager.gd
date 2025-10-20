extends Node

signal on_enemy_died;

const EXPLOSION_ANIM = preload("res://scenes/extra/explosion_anim.tscn")
var player: Player;
var coins: int = 500;

const COIN = preload("res://scenes/extra/coin.tscn");

func play_explosion_anim(pos: Vector2) -> void:
	var anim: AnimatedSprite2D = EXPLOSION_ANIM.instantiate();
	anim.global_position = pos;
	anim.z_index = 99;
	get_parent().add_child(anim);
	await anim.animation_finished;
	anim.queue_free();

func create_coin(pos: Vector2) -> void:
	var random_value = randf_range(0.0, 100.0);
	if random_value <= 70:
		var coin := COIN.instantiate() as Coin;
		coin.global_position = pos;
		get_parent().call_deferred("add_child", coin);

func remove_coins(amount: int) -> void:
	coins -= amount;
	if coins <= 0:
		coins = 0;
