extends KinematicBody2D

onready var ground_ray = get_node("ground-ray")
onready var bulletAnimations = get_node("gattling/bullet/AnimationPlayer")

const MOVE_SPEED = 800
const GRAVITY = 20
const JUMP_FORCE = -700
const HIGH_JUMP_FORCE = -1500
const FLOOR = Vector2(0, -1)

var movement = Vector2(0, 0)
var on_floor = false
var dir = "right"
var is_low = false
var anim

# warning-ignore:unused_argument
func _physics_process(delta):
	playerMovement()
	
func playerMovement():
	if Input.is_action_pressed("ui_right"):
		movement.x = MOVE_SPEED
		dir = "right"
		
		if Input.is_action_pressed("ui_down") and on_floor:
			anim = "move-low-right"
			is_low = true
		elif not is_low:
			anim = "move-right"
	elif Input.is_action_pressed("ui_left"):
		movement.x = -MOVE_SPEED
		dir = "left"
		
		if Input.is_action_pressed("ui_down") and on_floor:
			anim = "move-low-left"
			is_low = true
		elif not is_low:
			anim = "move-left"
		
	elif Input.is_action_pressed("ui_down") and on_floor:
		if anim == "idle-right":
			anim = "low-right"
		elif anim == "idle-left":
			anim = "low-left"
	else:
		movement.x = 0
		is_low = false
		
		if dir == "right":
			if is_low:
				anim = "low-right"
			else:
				anim = "idle-right"
		else:
			if is_low:
				anim = "low-left"
			else:
				anim = "idle-left"

	if Input.is_action_pressed("ui_up") and on_floor:
		movement.y = JUMP_FORCE
		is_low = false

	if Input.is_action_just_released("ui_down") and on_floor:
		movement.y = HIGH_JUMP_FORCE
		is_low = false
			
	if Input.is_action_pressed("ui_space"):
		bulletAnimations.play("shoot")
	else:
		bulletAnimations.play("idle")
			
	$AnimationPlayer.play(anim)
	
	movement.y += GRAVITY
	
	if ground_ray.is_colliding():
		on_floor = true
	else:
		on_floor = false
	
	movement = move_and_slide(movement, FLOOR)
	