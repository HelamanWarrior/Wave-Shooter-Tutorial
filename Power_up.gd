extends Sprite

export(String) var player_variable_modify
export(float) var player_variable_set

export(float) var power_up_cool_down = 2

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player"):
		area.get_parent().set(player_variable_modify, player_variable_set)
		area.get_parent().get_node("Power_up_cool_down").wait_time = power_up_cool_down
		area.get_parent().get_node("Power_up_cool_down").start()
		area.get_parent().power_up_reset.append(name)
		queue_free()
