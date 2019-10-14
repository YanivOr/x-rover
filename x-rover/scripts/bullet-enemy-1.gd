extends RigidBody2D

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.name == 'tilemap-1':
			pass
		elif body.name == 'player':
			global.decrement_lives()
			get_tree().reload_current_scene()
			pass
		else:
			pass

		queue_free()

func _on_Timer_timeout():
	queue_free()
