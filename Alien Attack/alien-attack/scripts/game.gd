extends Node2D
@export var lives = 3;
var score = 0;
@onready var player = $Player;
# delte enemy when hit enemy zone
func _on_deathzone_area_entered(area: Area2D) -> void:
	area.die();

# subtract lives by 1
func _on_player_took_damage() -> void:
	lives -= 1;
	if (lives == 0):
		print("Game Over");
		player.die();
	else:
		print(lives);

# add access to enemy when enemy not in game
func _on_enemy_spawner_enemy_spawned(enemy_instance: Variant) -> void:
	enemy_instance.connect("died",_on_enemy_died);
	add_child(enemy_instance);

func _on_enemy_died():
	score += 100;
	print("Score: " + str(score));
