extends Node3D

var level_name = "tutorial"
var thread
var current_level

func _ready():
	load_level()

func load_level():
	current_level = LevelManager.load_level(level_name)
	current_level.init(self)

func _input(event):
	if Input.is_action_just_pressed("main_menu"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_ring_stack_clicked(id):
	print("Ring stack " + str(id) + " clicked")
	GameManager.process_ring_stack_click(id)
