extends KinematicBody2D

onready var ground_ray = get_node("ground-ray")
onready var bulletAnimations = get_node("gattling/bullet/AnimationPlayer")
onready var shootingFireAnimations = get_node("gattling/shooting_fire/AnimationPlayer")
onready var exhaustSmokeAnimations = get_node("exhaust/exhaust-smoke/AnimationPlayer")

const MOVE_SPEED = 800
const GRAVITY = 20
const JUMP_FORCE = -700
const HIGH_JUMP_FORCE = -1500
const FLOOR = Vector2(0, -1)

var velocity = Vector2(0, 0)
var on_floor = false
var dir = "right"
var is_low = false
var anim

# warning-ignore:unused_argument
func _physics_process(delta):
	playerMovement()
	
func playerMovement():
	exhaustSmokeAnimations.play("driving")
			
	if Input.is_action_pressed("ui_right"):
		velocity.x = MOVE_SPEED
		dir = "right"
		
		if Input.is_action_pressed("ui_down") and on_floor:
			anim = "move-low-right"
			is_low = true
		elif not is_low:
			anim = "move-right"
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -MOVE_SPEED
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
		velocity.x = 0
		is_low = false
		
		exhaustSmokeAnimations.play("idle")
		
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
		velocity.y = JUMP_FORCE
		is_low = false

	if Input.is_action_just_released("ui_down") and on_floor:
		velocity.y = HIGH_JUMP_FORCE
		is_low = false
			
	if Input.is_action_pressed("ui_space"):
		bulletAnimations.play("shoot")
		shootingFireAnimations.play("shooting")
	else:
		bulletAnimations.play("idle")
		shootingFireAnimations.play("idle")
			
	$AnimationPlayer.play(anim)
	
	if ground_ray.is_colliding():
		on_floor = true
	else:
		on_floor = false
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)
	