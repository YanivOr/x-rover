extends Area2D

func _on_Potion_body_entered(body):
	if body.get_name() == 'player':
		global.increment_lives()
		queue_free()