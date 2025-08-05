extends Node

const COINS = preload("res://Idle Tycoon Assets/Sound/coins.wav")
const NORMAL_SFX = preload("res://Idle Tycoon Assets/Sound/normal sfx.mp3")

@export var stream_players: Array[AudioStreamPlayer];

func play_audio(clip: AudioStream, volume: float) -> void:
	var player := get_free_audio_player();
	if player == null:
		return
	
	player.stream = clip;
	player.volume_db = volume;
	player.play();

func play_coin() -> void:
	play_audio(COINS, 15);

func play_ui() -> void:
	play_audio(NORMAL_SFX, 0.5);
	

func get_free_audio_player() -> AudioStreamPlayer:
	for audio: AudioStreamPlayer in stream_players:
		if not audio.playing:
			return audio;
	return null;
