extends Node2D


@export var speed: float = 80.0


@onready var label: Label = $Label
@onready var nav_agent_2d: NavigationAgent2D = $NavAgent2D


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("set_target"):
		nav_agent_2d.target_position = get_global_mouse_position();


func _physics_process(delta: float) -> void:	
	update_label()
	
	if nav_agent_2d.is_navigation_finished(): return;
	
	var npp: Vector2 = nav_agent_2d.get_next_path_position();
	var dir: Vector2 = global_position.direction_to(npp);
	position += dir * speed * delta;
	rotation = dir.angle();


func update_label() -> void:
	var s: String = "TP:%.0v\n" % nav_agent_2d.target_position;
	s += "Reachable:%s\n" % nav_agent_2d.is_target_reachable();
	s += "Reached:%s\n" % nav_agent_2d.is_target_reached();
	s += "Finished:%s\n" % nav_agent_2d.is_navigation_finished();
	label.text = s;
