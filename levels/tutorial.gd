extends Node

func init(node):
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
	
	GameManager.spawn_ring_stack(node, parameters1)
	GameManager.spawn_ring_stack(node, parameters2)
	GameManager.spawn_ring_stack(node, parameters3)
