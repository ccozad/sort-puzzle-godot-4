extends Node3D

func _input(event):
	if Input.is_action_just_pressed("main_menu"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

func load_scene(name):
	GameManager.level_name = name
	GameManager.reset_level()
	get_tree().change_scene_to_file("res://main.tscn")

func _on_level_1_button_pressed() -> void:
	load_scene("tutorial")

func _on_level_2_button_pressed() -> void:
	pass # Replace with function body.

func _on_level_3_button_pressed() -> void:
	pass # Replace with function body.

func _on_level_4_button_pressed() -> void:
	pass # Replace with function body.

func _on_level_5_button_pressed() -> void:
	pass # Replace with function body.

func _on_level_6_button_pressed() -> void:
	pass # Replace with function body.

func _on_level_7_button_pressed() -> void:
	pass # Replace with function body.

func _on_level_8_button_pressed() -> void:
	pass # Replace with function body.

func _on_level_9_button_pressed() -> void:
	pass # Replace with function body.

func _on_level_10_button_pressed() -> void:
	pass # Replace with function body.
