extends Node3D

@onready var cpu_particles_3d: CPUParticles3D = $CPUParticles3D

@export var start_color = Color(1.0, 0, 0)
@export var end_color = Color(1.0, 0.0, 0.0, 0.0)

func init(parameters):
	if parameters.has("start_color"):
		start_color = parameters.start_color
	
	if parameters.has("end_color"):
		end_color = parameters.end_color
	
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cpu_particles_3d.color = start_color
	var gradient_data = {
		0.0: start_color,
		1.0: end_color
	}
	var gradient = Gradient.new()
	gradient.offsets = gradient_data.keys()
	gradient.colors = gradient_data.values()
	cpu_particles_3d.color_ramp = gradient
	cpu_particles_3d.one_shot = true

func _process(_delta):
	if not cpu_particles_3d.emitting:
		queue_free()
