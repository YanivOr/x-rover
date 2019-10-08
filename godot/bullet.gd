extends RigidBody2D

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.name == 'TileMap':
			pass
		elif body.name == 'enemy-1' or body.name == 'enemy-2':
			body.call('gotShot')
			pass
		else:
			pass
			
		queue_free()
			
func _on_Timer_timeout():
	queue_free()
