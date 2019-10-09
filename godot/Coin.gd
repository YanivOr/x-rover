extends Area2D

func _on_Coin_body_entered(body):
	if body.get_name() == 'Vehicle':
		global.incrementScore()
		queue_free()
