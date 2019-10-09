extends CanvasLayer

func _ready():
	
	pass

func _process(delta):
	$"score-value".text = String(global.score)
	$"lives-value".text = String(global.lives)
