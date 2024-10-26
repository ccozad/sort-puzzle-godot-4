extends Node3D

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_settings_button_pressed() -> void:
	pass

func _on_exit_button_pressed() -> void:
	get_tree().quit()
