extends Poolable
class_name Explosion;

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var sound: AudioStreamPlayer = $Sound


func activate() -> void:
	super()
	cpu_particles_2d.restart()
	sound.play()
