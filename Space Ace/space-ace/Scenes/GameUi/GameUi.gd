class_name GameUi


extends Control


@onready var health_bar: HealthBar = $MarginContainer/HealthBar
@onready var music: AudioStreamPlayer = $Music


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.player_take_damage.connect(on_player_take_damage)


	
func on_player_take_damage(damage: int) -> void:
	health_bar.take_damage(damage)



func _on_health_bar_died() -> void:
	music.stop()
	get_tree().paused = true
