extends Node3D

@onready var six_ring_stack: SixRingStack = $"six-ring-stack"

func _on_update_materials_button_pressed() -> void:
	six_ring_stack.update_materials()

func _on_pop_button_pressed() -> void:
	six_ring_stack.pop()

func _on_push_red_button_pressed() -> void:
	six_ring_stack.push({ "count": 1, "color": "red"})
