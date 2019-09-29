extends Node2D

var player_target
var player_died = false

func _ready():
	player_target = get_parent().get_node("Vehicle")
	pass

func _physics_process(delta):
	if player_died:
		pass
		
	position = player_target.get_position()
