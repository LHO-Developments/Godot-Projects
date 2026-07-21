class_name GameUi


extends Control


@onready var health_bar: HealthBar = $MarginContainer/HealthBar
@onready var music: AudioStreamPlayer = $Music
@onready var boost_sound: AudioStreamPlayer = $BoostSound
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var game_over_sound: AudioStreamPlayer = $GameOverSound
@onready var color_rect: ColorRect = $ColorRect

var _score: int = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	SignalHub.points_scored.connect(on_points_scored)
	SignalHub.player_take_damage.connect(on_player_take_damage)
	SignalHub.player_health_boost.connect(on_player_health_boost)


	
func on_player_take_damage(damage: int) -> void:
	health_bar.take_damage(damage)



func _on_health_bar_died() -> void:
	color_rect.show()
	game_over_sound.play()
	music.stop()
	get_tree().paused = true

func on_player_health_boost(boost: int) -> void:
	health_bar.incr_value(boost)
	boost_sound.play()

func on_points_scored(points: int) -> void:
	_score += points
	score_label.text = "%05d" % _score
