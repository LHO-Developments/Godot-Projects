extends Mover
class_name TargetedMover

@export var target_group: String = "player"

var _target: Node2D


func _ready() -> void:
	_target = get_tree().get_first_node_in_group(target_group)
	super()


func setup_velocity() -> void:
	assert(_target, "TargetedMover has no target!")
	if _target:
		_velocity = speed * _parent.global_position.direction_to(
			_target.global_position
		)
