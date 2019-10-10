extends CanvasLayer

func _process(delta):
	$"score-value".text = String(global.score)
	$"lives-value".text = String(global.lives)

func show_key():
	var key = preload("res://Key.tscn").instance()
	key.scale.x = 0.3
	key.scale.y = 0.3
	key.position.x = get_viewport().size.x - 50
	key.position.y = 30
	add_child(key)
