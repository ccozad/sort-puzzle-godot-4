extends RigidBody3D

const EXPLOSION = preload("res://scenes/explosion.tscn")

@export var initialized = false
@export var elapsed_time = 0
@export var detonation_time = 1.0
@export var start_color = Color(1.0, 0, 0)
@export var end_color = Color(1.0, 0.0, 0.0, 0.0)

func init(parent, parameters):
	if parameters.has("linear_velocity"):
		linear_velocity = parameters.linear_velocity
	
	if parameters.has("detonation_time"):
		detonation_time = parameters.detonation_time
	
	if parameters.has("start_color"):
		start_color = parameters.start_color
	
	if parameters.has("end_color"):
		end_color = parameters.end_color
	
	initialized = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not initialized:
		linear_velocity = Vector3(0, 12, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time > detonation_time:
		var effect =  EXPLOSION.instantiate()
		effect.init({
			"start_color": start_color,
			"end_color": end_color
		})
		effect.transform = self.transform
		SoundManager.explosion()
		get_parent().add_child(effect)
		queue_free()
