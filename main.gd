extends Node3D

@onready var level_completed_mask: MeshInstance3D = $LevelCompletedMask
@onready var level_completed_ground: MeshInstance3D = $LevelCompletedGround
@onready var level_completed_dialog: VBoxContainer = $CanvasLayer/LevelCompletedDialog

var level_name = "tutorial"
var thread
var current_level
var rocket_show
var level_completed = false
var celebration_started = false

func _ready():
	level_completed_mask.visible = false
	level_completed_ground.visible = false
	level_completed_dialog.visible = false
	GameManager.connect("level_completed", Callable(self, "_on_level_completed"))
	load_level()

func load_level():
	current_level = LevelManager.load_level(level_name)
	current_level.init(self)

func _input(event):
	if Input.is_action_just_pressed("main_menu"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _process(delta: float):
	if level_completed and not celebration_started:
		start_celebration()
	elif level_completed and celebration_started:
		rocket_show.process(self, delta)

func start_celebration():
	print("Starting celebration")
	rocket_show = GameManager.spawn_rocket_show(self, Vector3(0, -0.25, 3.8))
	celebration_started = true
	
func _on_ring_stack_clicked(id):
	print("Ring stack " + str(id) + " clicked")
	GameManager.process_ring_stack_click(id)

func _on_level_completed():
	print("Level completed")
	level_completed = true
	level_completed_mask.visible = true
	level_completed_ground.visible = true
	level_completed_dialog.visible = true
	SoundManager.level_completed()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
