extends Node3D

@onready var cpu_particles_3d: CPUParticles3D = $CPUParticles3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cpu_particles_3d.one_shot = true

func _process(_delta):
	if not cpu_particles_3d.emitting:
		queue_free()
