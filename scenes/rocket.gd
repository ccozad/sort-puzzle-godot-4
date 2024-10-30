extends RigidBody3D

const EXPLOSION = preload("res://scenes/explosion.tscn")

var initialized = false
var elapsed_time = 0
var detonation_time = 1.0

func init(parent, parameters):
	if parameters.has("linear_velocity"):
		linear_velocity = parameters.linear_velocity
	
	if parameters.has("detontation_time"):
		detonation_time = parameters.detonation_time
	
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
		effect.transform = self.transform
		get_parent().add_child(effect)
		queue_free()
