extends RigidBody2D

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.name == 'TileMap':
			pass	
		if body.has_method("gotShot"):
			body.call("gotShot")
			
		queue_free()
			
func _on_Timer_timeout():
	pass
	#queue_free()