extends Area2D

func _on_Key_body_entered(body):
	if body.get_name() == 'player':
		global.got_key()
		queue_free()
