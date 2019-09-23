extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var vehicle = get_node("Vehicle")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("vehicle: ", vehicle)
	vehicle.play("moving-21")
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vehicle.play("moving-1")
#	pass
