extends Control



#reset to first level
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn");
