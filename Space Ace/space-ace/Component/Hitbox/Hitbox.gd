@tool
class_name HitBox


extends Area2D

signal died(collided_with: Area2D);
signal hit(damage: int);

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var max_collisions: int = 1
@export var damage_dealt: int = 15

var _collisions_left: int = 0


@export var collision_shape: Shape2D:
	set(value):
		collision_shape = value
		if is_node_ready():
			apply_shape()



func apply_shape() -> void:
	collision_shape_2d.shape = collision_shape


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_shape()
	reset();


func reset() -> void:
	print(get_parent().name, " hitbox reset")
	_collisions_left = max_collisions


func _on_area_entered(area: Area2D) -> void:
	if area is HitBox: hit.emit(area.damage_dealt);
	_collisions_left -= 1
	if _collisions_left <= 0:
		print(get_parent().name, " hitbox died")
		died.emit(area)
