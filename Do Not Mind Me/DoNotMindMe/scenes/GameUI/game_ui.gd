extends Control

@onready var collected_label: Label = $MarginContainer/CollectedLabel
@onready var time_label: Label = $MarginContainer/TimeLabel
@onready var exit_label: Label = $MarginContainer/ExitLabel


var _pill_count: int = 0;
var _collected: int = 0;
var _time: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_pill_collected.connect(on_pill_collected);
	_pill_count = get_tree().get_nodes_in_group("pill").size();
	update_collected_label();

func _process(delta: float) -> void:
	_time += delta;
	time_label.text = "%.1fs" % _time;


func update_collected_label() -> void:
		collected_label.text = "%s / %s" % [_collected, _pill_count];

func on_pill_collected() -> void:
	_collected += 1;
	update_collected_label();
	if _collected == _pill_count:
		exit_label.show();
		SignalHub.emit_on_show_exit();
