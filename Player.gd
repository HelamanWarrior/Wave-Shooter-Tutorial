extends Sprite

var speed = 150
var velocity = Vector2()

var bullet = preload("res://Bullet.tscn")

var can_shoot = true
var is_dead = false

var damage = 1
var default_damage = damage

var reload_speed = 0.1
var default_reload_speed = reload_speed

var power_up_reset = []

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null

func _process(delta):
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	velocity = velocity.normalized()
	
	global_position.x = clamp(global_position.x, 24, 616)
	global_position.y = clamp(global_position.y, 24, 336)
	
	if is_dead == false:
		global_position += speed * velocity * delta
	
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot and is_dead == false:
		var bullet_instance = Global.instance_node(bullet, global_position, Global.node_creation_parent)
		bullet_instance.damage = damage
		$Reload_speed.start()
		can_shoot = false
	
func _on_Reload_speed_timeout():
	can_shoot = true
	$Reload_speed.wait_time = reload_speed

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		is_dead = true
		visible = false
		Global.save_game()
		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()

func _on_Power_up_cool_down_timeout():
	if power_up_reset.find("Power_up_reload") != null:
		reload_speed = default_reload_speed
		power_up_reset.erase("Power_up_reload")
	elif power_up_reset.find("Power_up_damage") != null:
		damage = default_damage
		power_up_reset.erase("Power_up_damage")
