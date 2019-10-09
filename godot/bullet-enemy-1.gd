extends RigidBody2D

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.name == 'TileMap':
			pass
		elif body.name == 'Vehicle':
			global.decrementLives()
			get_tree().reload_current_scene()
			pass
		else:
			pass

		queue_free()

func _on_Timer_timeout():
	queue_free()
