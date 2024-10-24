extends Node3D

@onready var select_sound: AudioStreamPlayer = $SelectSound
@onready var unselect_sound: AudioStreamPlayer = $UnselectSound

func select_rings():
	select_sound.play()

func unselect_rings():
	unselect_sound.play()
