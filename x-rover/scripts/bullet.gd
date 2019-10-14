extends RigidBody2D

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.name == 'tilemap-1':
			pass
		if body.has_method("got_shot"):
			body.call("got_shot")
			
		queue_free()
			
func _on_Timer_timeout():
	queue_free()
