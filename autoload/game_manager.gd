extends Node

const SIX_RING_STACK = preload("res://scenes/six_ring_stack.tscn")

var source_id = null
var destination_id = null

var ring_stacks = {}

func spawn_ring_stack(root_node, parameters):
	var ring_stack = SIX_RING_STACK.instantiate()
	ring_stack.init(root_node, parameters)
	ring_stacks[ring_stack.id] = ring_stack
	root_node.add_child(ring_stack)

func process_ring_stack_click(id):
	if source_id == null:
		if ring_stacks[id].item_count:
			source_id = id
			ring_stacks[id].set_selected(true)
	elif source_id == id:
		if ring_stacks[id].item_count:
			source_id = null
			ring_stacks[id].set_selected(false)
	else:
		destination_id = id
		var top_destination_group = ring_stacks[destination_id].top()
		var top_source_group = ring_stacks[source_id].top()
		var destination_item_count = ring_stacks[destination_id].item_count
		var destination_max_capacity = ring_stacks[destination_id].max_capacity
		var transfer = false
		
		if top_destination_group == null:
			transfer = true
		elif destination_item_count + top_source_group.count <= destination_max_capacity and top_source_group.color == top_destination_group.color:
			transfer = true
		
		if transfer:
			ring_stacks[source_id].pop()
			ring_stacks[destination_id].push(top_source_group)
			
		ring_stacks[source_id].set_selected(false)
		source_id = null
		destination_id = null
			
