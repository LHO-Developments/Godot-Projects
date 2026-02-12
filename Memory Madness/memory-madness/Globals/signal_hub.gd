extends Node

signal on_level_selected(level_setting: LevelSetting);

func emit_on_level_selected(level_setting: LevelSetting) -> void:
	on_level_selected.emit(level_setting);
