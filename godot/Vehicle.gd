extends KinematicBody2D

#onready var player = get_node("Animation")

const MOVE_SPEED = 400
const GRAVITY = 20
const JUMP_FORCE = -850
const FLOOR = Vector2(0, -1)

var movement = Vector2(0, 0)
var anim
var on_floor = false

func _physics_process(delta):
	playerMovement()
	
func playerMovement():
	if Input.is_action_pressed("ui_right"):
		movement.x = MOVE_SPEED
#		player.set_flip_h(false)
		anim = "Walk"
	elif Input.is_action_pressed("ui_left"):
		movement.x = -MOVE_SPEED
#		player.set_flip_h(true)
		anim = "Walk"
	else:
		movement.x = 0
		anim = "Idle"
	
	if Input.is_action_pressed("ui_up") and on_floor:
		movement.y = JUMP_FORCE
		
#	player.play(anim)
	movement.y += GRAVITY
	
	if is_on_floor():
		on_floor = true
	else:
		on_floor = false
	
	movement = move_and_slide(movement, FLOOR)
	