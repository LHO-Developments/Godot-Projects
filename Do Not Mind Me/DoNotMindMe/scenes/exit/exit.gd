extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide();
	SignalHub.on_show_exit.connect(_on_show_exit);


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Player Entered");

func _on_show_exit() -> void:
	set_monitoring.call_deferred(true);
	show();
