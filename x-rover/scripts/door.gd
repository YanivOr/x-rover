extends Area2D

func _on_Door_body_entered(body):
	if body.get_name() == 'player':
		print("Level completed")
