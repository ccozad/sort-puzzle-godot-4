extends Node3D

@onready var six_ring_stack: SixRingStack = $"six-ring-stack"

func _ready():
	six_ring_stack.update_materials()

func _on_update_materials_button_pressed() -> void:
	six_ring_stack.update_materials()

func _on_pop_button_pressed() -> void:
	six_ring_stack.pop()

func _on_push_red_button_pressed() -> void:
	six_ring_stack.push({ "count": 1, "color": "red"})

func _on_push_green_button_pressed() -> void:
	six_ring_stack.push({ "count": 1, "color": "green"})

func _on_push_blue_button_pressed() -> void:
	six_ring_stack.push({ "count": 1, "color": "blue"})

func _on_push_pink_button_pressed() -> void:
	six_ring_stack.push({ "count": 1, "color": "pink"})

func _on_push_teal_button_pressed() -> void:
	six_ring_stack.push({ "count": 1, "color": "teal"})

func _on_push_yellow_button_pressed() -> void:
	six_ring_stack.push({ "count": 1, "color": "yellow"})
