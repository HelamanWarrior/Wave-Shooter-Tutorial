extends "res://Enemy_core.gd"

func _process(delta):
	basic_movement_towards_player(delta)
