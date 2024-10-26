extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("fade_in_fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	launch_menu_scene()

func launch_menu_scene():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
