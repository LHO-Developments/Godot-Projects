class_name GameUi


extends Control


@onready var health_bar: HealthBar = $MarginContainer/HealthBar
@onready var music: AudioStreamPlayer = $Music
@onready var boost_sound: AudioStreamPlayer = $BoostSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.player_take_damage.connect(on_player_take_damage)
	SignalHub.player_health_boost.connect(on_player_health_boost)


	
func on_player_take_damage(damage: int) -> void:
	health_bar.take_damage(damage)



func _on_health_bar_died() -> void:
	music.stop()
	get_tree().paused = true

func on_player_health_boost(boost: int) -> void:
	health_bar.incr_value(boost)
	boost_sound.play()
