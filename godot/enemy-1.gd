extends Node2D

const BULLET_VELOCITY = 3000

var shooting_time = 0

func _physics_process(delta):
	shooting_time += delta
	var shooting_interval = randf() * 11
	print(shooting_interval)
	
	if shooting_time > shooting_interval:
		var bullet_enemy = preload("res://bullet-enemy-1.tscn").instance()
		var bullet_enemy_dir = -1
		bullet_enemy.get_node("Sprite").set_flip_h(true)
		bullet_enemy.position = global_position
		bullet_enemy.position.x += 140 * bullet_enemy_dir
		bullet_enemy.position.y -= 77
		bullet_enemy.linear_velocity = Vector2(bullet_enemy_dir * BULLET_VELOCITY, 0)
		bullet_enemy.add_collision_exception_with(self)
		get_parent().add_child(bullet_enemy)
		shooting_time = 0