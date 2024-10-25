extends Label

@export var show_debug = true

var FPS = 0
var draw_calls = 0
var frame_time = 0
var VRAM = 0
var ring_count = 0
var ring_holder_count = 0
var data

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not show_debug:
		text = ""
		return
	else:
		FPS = Engine.get_frames_per_second()
		draw_calls = RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_DRAW_CALLS_IN_FRAME)
		frame_time = "%0.1f" % (delta * 1000)
		VRAM = RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_VIDEO_MEM_USED) / 1024.0 / 1024.0
		ring_count = get_tree().get_nodes_in_group("Ring").size()
		ring_holder_count = get_tree().get_nodes_in_group("Ring Holder").size()
		data = "FPS: " + str(FPS) + "\n" + \
		"Draw calls: " + str(draw_calls) + "\n" + \
		"Frame time: " + frame_time + "ms\n" + \
		"VRAM: " + "%0.1f" % VRAM + " MB\n" + \
		"Ring count: " + str(ring_count) + "\n" + \
		"Ring holder count: " + str(ring_holder_count)
		text = data
