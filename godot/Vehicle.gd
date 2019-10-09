extends KinematicBody2D

onready var ground_ray = get_node("ground-ray")
onready var exhaust_smoke_animations = get_node("exhaust/exhaust-smoke/AnimationPlayer")
onready var shooting_fire_animations = get_node("gattling/shooting_fire/AnimationPlayer")

const MOVE_SPEED = 1500
const GRAVITY = 60
const JUMP_FORCE = -1500
const HIGH_JUMP_FORCE = -3000
const FLOOR = Vector2(0, -1)
const BULLET_VELOCITY = 6000

var velocity = Vector2(0, 0)
var on_floor = false
var dir = "right"
var is_low = false
var anim
var bullet_dir
var shooting_time = 0
var shooting_interval = 0.15

# warning-ignore:unused_argument
func _physics_process(delta):
	shooting_time += delta
	
	exhaust_smoke_animations.play("driving")
			
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
		
		exhaust_smoke_animations.play("idle")
		
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
		shooting_fire_animations.play("shooting")
	else:
		shooting_fire_animations.play("idle")
		
	if Input.is_action_pressed("ui_space") and shooting_time > shooting_interval:
		var bullet = preload("res://bullet.tscn").instance()
		
		if dir == "right":
			bullet_dir = 1
			bullet.get_node("Sprite").set_flip_h(false)
		else:
			bullet_dir = -1
			bullet.get_node("Sprite").set_flip_h(true)
		
		bullet.position = $gattling.global_position
		bullet.position.x += 40 * bullet_dir
		bullet.linear_velocity = Vector2(bullet_dir * BULLET_VELOCITY, 0)
		bullet.add_collision_exception_with(self)
		get_parent().add_child(bullet)

		shooting_time = 0
			
	$AnimationPlayer.play(anim)
	
	if ground_ray.is_colliding():
		on_floor = true
	else:
		on_floor = false
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)
	