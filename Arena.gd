extends Node2D

export(Array, PackedScene) var enemies
export(Array, PackedScene) var power_ups

func _ready():
	Global.node_creation_parent = self
	
	Global.points = 0

func _exit_tree():
	Global.node_creation_parent = null

func _on_Enemy_spawn_timer_timeout():
	var enemy_position = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.y < 360 and enemy_position.y > -45:
		enemy_position = Vector2(rand_range(-160, 670), rand_range(-90, 390))
	
	var enemy_number = round(rand_range(0, enemies.size() - 1))
	
	Global.instance_node(enemies[enemy_number], enemy_position, self)

func _on_Difficulty_timer_timeout():
	if $Enemy_spawn_timer.wait_time > 0.5:
		$Enemy_spawn_timer.wait_time -= 0.025

func _on_Power_up_spawn_timer_timeout():
	var power_up_number = round(rand_range(0, power_ups.size() - 1))
	
	Global.instance_node(power_ups[power_up_number], Vector2(rand_range(0, 640), rand_range(0, 360)), self)
