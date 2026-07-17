class_name PowerUp


extends Poolable

func _on_life_timer_timeout() -> void:
	deactivate();
