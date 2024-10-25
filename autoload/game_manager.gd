extends Node

const SIX_RING_STACK = preload("res://scenes/six_ring_stack.tscn")

func spawn_ring_stack(root_node, parameters):
	var ring_stack = SIX_RING_STACK.instantiate()
	ring_stack.init(parameters)
	root_node.add_child(ring_stack)
