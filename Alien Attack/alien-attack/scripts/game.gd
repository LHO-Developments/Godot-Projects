extends Node2D
@export var lives = 3;
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
