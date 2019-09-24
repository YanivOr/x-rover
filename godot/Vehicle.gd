extends KinematicBody2D

const MOVE_SPEED = 400
const GRAVITY = 20
const JUMP_FORCE = -500
const FLOOR = Vector2(0, -1)

var movement = Vector2(0, 0)
var on_floor = false

# warning-ignore:unused_argument
func _physics_process(delta):
	playerMovement()
	
func playerMovement():
	if Input.is_action_pressed("ui_right"):
		movement.x = MOVE_SPEED
		$AnimationPlayer.play("move-right")
	elif Input.is_action_pressed("ui_left"):
		movement.x = -MOVE_SPEED
		$AnimationPlayer.play("move-left")
	else:
		movement.x = 0
		$AnimationPlayer.play("idle")
	
	if Input.is_action_pressed("ui_up") and on_floor:
		movement.y = JUMP_FORCE
		
	movement.y += GRAVITY
	
	if is_on_floor():
		on_floor = true
	else:
		on_floor = false
	
	movement = move_and_slide(movement, FLOOR)
	