extends Node2D
class_name Poolable

var is_available: bool:
	get: return !visible


func _enter_tree() -> void:
	deactivate()


func activate() -> void:
	set_deferred("process_mode", Node.PROCESS_MODE_INHERIT)
	show()


func deactivate() -> void:
	set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
	hide()
