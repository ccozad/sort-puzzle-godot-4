class_name SixRingStack
extends Node3D

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
	"yellow": Color(1, 1, 0)
}

var ring_meshes = []

var ring_groups = []
# ring_grouops = [
# 	{ "count": 1, "color": "red"},
# 	{ "count": 1, "color": "green"},
# 	{ "count": 1, "color": "blue"},
# 	{ "count": 1, "color": "teal"},
# 	{ "count": 1, "color": "pink"},
# 	{ "count": 1, "color": "yellow"}
# ]

const max_capacity = 6
var item_count = 0 

func init(_ring_groups):
	ring_groups = _ring_groups
	item_count = 0
	for group in ring_groups:
		item_count = item_count + group.count

func top():
	if ring_groups.count == 0:
		return null
	else:
		return ring_groups[-1]

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

func pop():
	if ring_groups.size() == 0:
		return null
	else:
		var last_group = ring_groups.pop_back()
		item_count = item_count - last_group.count
		update_materials()
		return last_group

func update_materials():
	for mesh in ring_meshes:
		mesh.visible = false
	
	var current_index = 0
	for group in ring_groups:
		for i in range(current_index, current_index + group.count):
			ring_meshes[i].visible = true
			if color_map.has(group.color):
				var material: StandardMaterial3D = ring_meshes[i].get_surface_override_material(0) as StandardMaterial3D
				material.albedo_color = color_map[group.color]

		current_index = current_index + group.count

func _ready():
	ring_meshes = [
		ring_0,
		ring_1,
		ring_2,
		ring_3,
		ring_4,
		ring_5
	]
	