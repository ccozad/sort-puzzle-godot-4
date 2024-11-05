extends Node

const SIX_RING_STACK = preload("res://scenes/six_ring_stack.tscn")
const ROCKET_SHOW = preload("res://scenes/rocket_show.tscn")

var source_id = null
var destination_id = null
var all_solved = false
var move_count = 0
var level_name = ""

var ring_stacks = {}

signal move_completed()
signal level_completed()
var level_completed_broadcast = false

func reset_level():
	level_completed_broadcast = false
	move_count = 0

func spawn_ring_stack(root_node, parameters):
	print("Spawn ring stack")
	var ring_stack = SIX_RING_STACK.instantiate()
	ring_stack.init(root_node, parameters)
	ring_stacks[ring_stack.id] = ring_stack
	root_node.add_child(ring_stack)

func spawn_rocket_show(root_node, position):
	print("Spawn rocket show")
	var rocket_show = ROCKET_SHOW.instantiate()
	rocket_show.init()
	root_node.add_child(rocket_show)
	return rocket_show

func calculate_all_solved():
	var result = true
	for id in ring_stacks.keys():
		result = result and ring_stacks[id].is_solved()
	
	all_solved = result
	
	return result	

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
			move_count = move_count + 1
			move_completed.emit()
			
		ring_stacks[source_id].set_selected(false)
		source_id = null
		destination_id = null
		calculate_all_solved()
		if all_solved and not level_completed_broadcast:
			print("Level completed signal broadcast")
			level_completed.emit()
			level_completed_broadcast = true
			
