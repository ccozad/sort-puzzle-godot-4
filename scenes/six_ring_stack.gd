class_name SixRingStack
extends Node3D

signal clicked(id)

@onready var ring_0: MeshInstance3D = $Ring_0
@onready var ring_1: MeshInstance3D = $Ring_1
@onready var ring_2: MeshInstance3D = $Ring_2
@onready var ring_4: MeshInstance3D = $Ring_4
@onready var ring_3: MeshInstance3D = $Ring_3
@onready var ring_5: MeshInstance3D = $Ring_5

var color_map = {
	"blue": Color(0, 0, 1),
	"red": Color(1, 0, 0),
	"green": Color(0, 1, 0),
	"pink": Color(1, 0, 1),
	"teal": Color(0, 1, 1),
	"yellow": Color(1, 1, 0),
	"white": Color(1, 1, 1)
}

var ring_meshes = []

var ring_groups = []

const max_capacity = 6
var item_count = 0
var selected = false
var id = "0" 

func init(root_node, parameters):
	if parameters.has("id"):
		id = parameters.id
	
	if parameters.has("ring_groups"):
		ring_groups = parameters.ring_groups
	item_count = 0
	for group in ring_groups:
		item_count = item_count + group.count
	
	if parameters.has("custom_transform"):
		if parameters.custom_transform.has("position"):
			self.translate(parameters.custom_transform.position)
	
	connect("clicked", Callable(root_node, "_on_ring_stack_clicked"))

func top():
	if ring_groups.size() == 0:
		return null
	else:
		return ring_groups[-1]

# Pushes the group if there is room and the color of the group 
# matches the top group
func push(group):
	print("Attempting to push with group" + str(group))
	var can_push = false
	if ring_groups.size() == 0:
		print("Ring groups size is 0")
		can_push = group.count <= max_capacity
	else:
		print("Ring groups size is greate than zero")
		var last_group_color = ring_groups[-1].color
		var open_space = max_capacity - item_count
		print("Last group color: " + last_group_color)
		print("Group color: " + group.color)
		print("Group count: " + str(group.count))
		print("Open space: " + str(open_space))
		can_push = group.count <= open_space && last_group_color == group.color
	 
	if can_push:
		print("Can push is true")
		if ring_groups.size() == 0:
			ring_groups.push_back(group)
			item_count = group.count
		else:
			ring_groups[-1].count = ring_groups[-1].count + group.count
			item_count = item_count + group.count
	else:
		print("Can push is false")
	
	update_materials()
	return can_push

# Removes the last group added to the spindle and returns it. 
# Returns null if the spindle is empty
func pop():
	if ring_groups.size() == 0:
		update_materials()
		return null
	else:
		var last_group = ring_groups.pop_back()
		item_count = item_count - last_group.count
		selected = false
		update_materials()
		return last_group

# Updates the visibility and color of all rings 
func update_materials():
	for mesh: MeshInstance3D in ring_meshes:
		mesh.visible = false
		mesh.remove_from_group("Ring")
	
	var current_index = 0
	var group_index = 0
	var last_group_index = ring_groups.size() - 1
	for group in ring_groups:
		for i in range(current_index, current_index + group.count):
			ring_meshes[i].visible = true
			ring_meshes[i].add_to_group("Ring")
			if color_map.has(group.color):
				var material: StandardMaterial3D = ring_meshes[i].get_surface_override_material(0) as StandardMaterial3D
				material.albedo_color = color_map[group.color]
				if group_index == last_group_index and selected:
					material.rim_enabled = true
				elif group_index == last_group_index and not selected:
					material.rim_enabled = false

		current_index = current_index + group.count
		group_index = group_index + 1

func toggle_selection():
	if item_count:
		selected = not selected
	
		update_materials()
		if selected:
			SoundManager.select_rings()
		else:
			SoundManager.unselect_rings()

func set_selected(_selected):
	if item_count:
		selected = _selected
		update_materials()
	
		if selected:
			SoundManager.select_rings()
		else:
			SoundManager.unselect_rings()

func _ready():
	ring_meshes = [
		ring_0,
		ring_1,
		ring_2,
		ring_3,
		ring_4,
		ring_5
	]
	update_materials()

func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			clicked.emit(id)
		
