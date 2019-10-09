extends StaticBody2D

const BULLET_VELOCITY = 3000

var shooting_time = 0

func _physics_process(delta):
	shooting_time += delta
	var shooting_interval = randf() * 15 + 1.5
	
	if shooting_time > shooting_interval:
		var bullet_enemy = preload("res://bullet-enemy-111.tscn").instance()
		var bullet_enemy_dir = -1
		bullet_enemy.get_node("Sprite").set_flip_h(true)
		
		if scale.x > 0:
			bullet_enemy_dir = 1
			bullet_enemy.get_node("Sprite").set_flip_h(false)

		bullet_enemy.position = global_position
		bullet_enemy.position.x += 160 * bullet_enemy_dir
		bullet_enemy.position.y -= 77
		bullet_enemy.linear_velocity = Vector2(bullet_enemy_dir * BULLET_VELOCITY, 0)
		bullet_enemy.add_collision_exception_with(self)
		get_parent().add_child(bullet_enemy)
		shooting_time = 0

func gotShot():
	var explosion = preload("res://Explosion-1.tscn").instance()
	explosion.position = global_position
	explosion.frame = 0
	explosion.play("explode")
	get_parent().add_child(explosion)
	queue_free()
	global.incrementScore()