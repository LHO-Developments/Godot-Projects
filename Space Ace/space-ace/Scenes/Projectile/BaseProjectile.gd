extends Poolable;
class_name BaseProjectile

@onready var life_timer: Timer = $LifeTimer


var _mover: Mover


func _ready() -> void:
	for c in get_children():
		if c is Mover:
			_mover = c
			break
	assert(_mover, "No mover on base projectile")


func activate() -> void:
	super()
	life_timer.start()
	_mover.setup_velocity()



func _on_life_timer_timeout() -> void:
	deactivate()


func _on_screen_notifier_screen_exited() -> void:
	if visible:
		deactivate()
