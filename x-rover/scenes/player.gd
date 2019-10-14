extends KinematicBody2D

onready var shooting_fire = preload("res://scenes/shooting-fire.tscn").instance()

onready var ground_ray = get_node("ground-ray")
onready var animated_sprites = get_node("animated-sprites")

const MOVE_SPEED = 400
const GRAVITY = 20
const JUMP_FORCE = -500
const HIGH_JUMP_FORCE = -800
const FLOOR = Vector2(0, -1)
const BULLET_VELOCITY = 6000

var velocity = Vector2(0, 0)
var is_on_floor = false
var is_right = true
var is_high = true
var is_driving = false
var is_jump_low = false
var is_jump_high = false
var is_shooting = false
var anim

func _physics_process(delta):
	handle_events()
	set_velocity()
	set_player()
	set_shooting_fire()
	animate_shooting_fire()
	verify_ground()
	play()
		
func handle_events():
	if Input.is_action_pressed("ui_right"):
		is_right = true
		is_driving = true
	if Input.is_action_pressed("ui_left"):
		is_right = false
		is_driving = true
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		is_driving = false
	if Input.is_action_pressed("ui_up") and is_on_floor:
		is_high = true
		is_jump_low = true
	if Input.is_action_just_released("ui_up"):
		is_high = true
	if Input.is_action_pressed("ui_down") and is_on_floor:
		is_high = false
	if Input.is_action_just_released("ui_down") and is_on_floor:
		is_high = true
		is_jump_high = true
	if Input.is_action_pressed("ui_space"):
		is_shooting = true
	if Input.is_action_just_released("ui_space"):
		is_shooting = false
		
func set_player():
	if is_driving and is_high:
		anim = "drive-high"
	elif is_driving and !is_high:
		anim = "drive-low"
	elif !is_driving and is_high:
		anim = "default-high"
	elif !is_driving and !is_high:
		anim = "default-low"
	
	if is_right:
		animated_sprites.flip_h = false
	else:
		animated_sprites.flip_h = true

func set_velocity():
	if is_driving and is_right:
		velocity.x = MOVE_SPEED
	elif is_driving and !is_right:
		velocity.x = -MOVE_SPEED
	else:
		velocity.x = 0

	if is_jump_low:
		velocity.y = JUMP_FORCE
		is_jump_low = false
	elif is_jump_high:
		velocity.y = HIGH_JUMP_FORCE
		is_jump_high = false
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)
	
func verify_ground():
	if ground_ray.is_colliding():
		is_on_floor = true
	else:
		is_on_floor = false

func play():
	animated_sprites.play(anim)

func set_shooting_fire():
	get_parent().add_child(shooting_fire)
	
func animate_shooting_fire():
	if is_shooting:
		shooting_fire.get_node("AnimationPlayer").play("shooting")
	else:
		shooting_fire.get_node("AnimationPlayer").play("idle")

	shooting_fire.position = global_position
	shooting_fire.position.y -= 20
			
	if is_right:
		shooting_fire.position.x += 70
		shooting_fire.scale.x = 1
	else:
		shooting_fire.position.x -= 70
		shooting_fire.scale.x = -1

