extends CanvasLayer

onready var key = get_node("key")

func _process(delta):
	$"score-value".text = String(global.score)
	$"lives-value".text = String(global.lives)

	if global.key:
		key.scale.x = 0.5
		key.scale.y = 0.5
		key.position.x = get_viewport().size.x - 50
		key.position.y = 30
