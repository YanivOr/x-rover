extends Area2D

func _on_door_body_entered(body):
	if body.get_name() == 'player' and global.key:
		get_tree().reload_current_scene()
