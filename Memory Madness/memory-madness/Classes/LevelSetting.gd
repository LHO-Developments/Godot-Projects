extends Resource
class_name LevelSetting;

@export var rows: int = 2;
@export var cols: int = 2;

var total_tiles: int:
	get: return rows * cols;
	

var target_pairs: int:
	get: return total_tiles / 2;

func _to_string() -> String:
	return "%dx%d" % [rows, cols];
