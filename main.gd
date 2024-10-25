extends Node3D

func _ready():
	var parameters1 = {
		"id": "rs-1",
		"custom_transform": {
			"position": Vector3(-3,0,0)
		},
		"ring_groups": [
 			{ "count": 1, "color": "red"},
 			{ "count": 1, "color": "green"},
 			{ "count": 1, "color": "blue"},
 			{ "count": 1, "color": "white"},
 			{ "count": 1, "color": "pink"},
 			{ "count": 1, "color": "yellow"}
		]
	}
	
	var parameters2 = {
		"id": "rs-2",
		"custom_transform": {
			"position": Vector3(0,0,0)
		},
		"ring_groups": [
 			{ "count": 1, "color": "red"},
 			{ "count": 1, "color": "green"},
 			{ "count": 1, "color": "blue"},
 			{ "count": 1, "color": "white"},
 			{ "count": 1, "color": "pink"},
 			{ "count": 1, "color": "yellow"}
		]
	}
	
	var parameters3 = {
		"id": "rs-3",
		"custom_transform": {
			"position": Vector3(3,0,0)
		},
		"ring_groups": []
	}
	
	GameManager.spawn_ring_stack(self, parameters1)
	GameManager.spawn_ring_stack(self, parameters2)
	GameManager.spawn_ring_stack(self, parameters3)

func _on_ring_stack_clicked(id):
	print("Ring stack " + str(id) + " clicked")
	GameManager.process_ring_stack_click(id)
