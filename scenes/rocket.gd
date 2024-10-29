extends RigidBody3D

const EXPLOSION = preload("res://scenes/explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity = Vector3(0, 12, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if linear_velocity.length() < 1:
		var effect =  EXPLOSION.instantiate()
		effect.transform = self.transform
		get_parent().add_child(effect)
		queue_free()
