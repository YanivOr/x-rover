extends KinematicBody2D

const MOVE_SPEED = 600
const GRAVITY = 20
const JUMP_FORCE = -700
const HIGH_JUMP_FORCE = -1500
const FLOOR = Vector2(0, -1)

var movement = Vector2(0, 0)
var on_floor = false
var dir = "right"
var anim

# warning-ignore:unused_argument
func _physics_process(delta):
	playerMovement()
	
func playerMovement():
	if Input.is_action_pressed("ui_right"):
		movement.x = MOVE_SPEED
		dir = "right"
		anim = "move-right"
	elif Input.is_action_pressed("ui_left"):
		movement.x = -MOVE_SPEED
		dir = "left"
		anim = "move-left"
	else:
		movement.x = 0
		if dir == "right":
			anim = "idle-right"
		else:
			anim = "idle-left"
			
	if Input.is_action_pressed("ui_up") and on_floor:
		movement.y = JUMP_FORCE
	elif Input.is_action_pressed("ui_down") and on_floor:
		if dir == "right":
			anim = "low-right"
		else:
			anim = "low-left"
	elif Input.is_action_just_released("ui_down") and on_floor:
		movement.y = HIGH_JUMP_FORCE

	$AnimationPlayer.play(anim)
	
	movement.y += GRAVITY
	
	if is_on_floor():
		on_floor = true
	else:
		on_floor = false
	
	movement = move_and_slide(movement, FLOOR)

	