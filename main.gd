extends Node3D

func _ready():
	var parameters1 = {
		"id": "rs-1",
		"custom_transform": {
			"position": Vector3(-3,0,0)
		},
		"target": 3,
		"ring_groups": [
 			{ "count": 1, "color": "red"},
 			{ "count": 2, "color": "blue"}
		]
	}
	
	var parameters2 = {
		"id": "rs-2",
		"custom_transform": {
			"position": Vector3(0,0,0)
		},
		"target": 3,
		"ring_groups": [
 			{ "count": 1, "color": "blue"},
 			{ "count": 2, "color": "red"}
		]
	}
	
	var parameters3 = {
		"id": "rs-3",
		"custom_transform": {
			"position": Vector3(3,0,0)
		},
		"target": 3,
		"ring_groups": []
	}
	
	GameManager.spawn_ring_stack(self, parameters1)
	GameManager.spawn_ring_stack(self, parameters2)
	GameManager.spawn_ring_stack(self, parameters3)

func _input(event):
	if Input.is_action_just_pressed("main_menu"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_ring_stack_clicked(id):
	print("Ring stack " + str(id) + " clicked")
	GameManager.process_ring_stack_click(id)
