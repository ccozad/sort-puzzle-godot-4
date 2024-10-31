extends Node3D

@onready var select_sound: AudioStreamPlayer = $SelectSound
@onready var unselect_sound: AudioStreamPlayer = $UnselectSound
@onready var win_sound: AudioStreamPlayer = $WinSound
@onready var firework_explosion: AudioStreamPlayer = $FireworkExplosion

func select_rings():
	select_sound.play()

func unselect_rings():
	unselect_sound.play()

func level_completed():
	win_sound.play()

func explosion():
	firework_explosion.play()
