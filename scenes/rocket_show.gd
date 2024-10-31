extends Node

const ROCKET = preload("res://scenes/rocket.tscn")

var timeline = []
var elapsed_time = 0.0
var previous_second = 0
var colors = [
	[Color(1.0, 1.0, 0.486), Color(1.0, 1.0, 0.486, 0.0)],
	[Color(1, 0.118, 0.486), Color(1, 0.118, 0.486, 0)],
	[Color(0.455, 0.003, 0.855), Color(0.455, 0.003, 0.855, 0)],
	[Color(0.131, 0.72, 0.378), Color(0.131, 0.72, 0.378, 0)],
	[Color(0.91, 0.463, 0.215), Color(0.91, 0.463, 0.215, 0)],
]

func init():
	timeline.append({"timestamp": 1, "wave": get_rocket_volley()})
	timeline.append({"timestamp": 3, "wave": get_rocket_volley()})
	timeline.append({"timestamp": 5, "wave": get_rocket_volley()})
	timeline.append({"timestamp": 7, "wave": get_rocket_volley()})
	timeline.append({"timestamp": 9, "wave": get_rocket_volley()})
	timeline.append({"timestamp": 11, "wave": get_rocket_volley()})
	timeline.append({"timestamp": 13, "wave": get_rocket_volley()})

func process(node, delta: float) -> void:
	elapsed_time += delta
	if elapsed_time - previous_second > 1.0:
		previous_second += 1
		for event in timeline:
			if event.timestamp <= elapsed_time and not event.has("processed"):
				if event.has("wave"):
					process_wave(node, event.wave)
					event.processed = true

func process_wave(node, wave):
	print("Process wave called")
	for item in wave:
		var scene = item.scene.instantiate()
		scene.init(node, item.parameters)
		scene.add_to_group("Rocket")
		node.add_child(scene)

func get_rocket_volley():
	var wave = []
	var rocket_count = 5
	for i in rocket_count:
		var color_index = randi_range(0, colors.size()-1)
		wave.append({
			"scene": ROCKET,
			"parameters": {
				"linear_velocity": Vector3(randi_range(-8,8), randi_range(13,20), -1),
				"detonation_time": randf_range(0.9,2.2),
				"start_color":  colors[color_index][0],
				"end_color": colors[color_index][1]
			}
		})
	return wave
