extends Area2D

func _on_Key_body_entered(body):
	if body.get_name() == 'Vehicle':
		global.gotKey()
		queue_free()
