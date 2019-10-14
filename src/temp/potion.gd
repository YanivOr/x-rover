extends Area2D

func _on_Potion_body_entered(body):
	if body.get_name() == 'Vehicle':
		global.incrementLives()
		queue_free()