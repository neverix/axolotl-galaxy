extends KinematicBody2D

var velocity = Vector2 (0, 0)
export var gravity_acceleration = Vector2 (0, 1)
export var strong_gravity_acceleration = Vector2 (0, 1.2)
export var jump_force = Vector2 (0, -4)
export var jump_gravity_acceleration = Vector2 (0, 0.5)
export var move_force = Vector2 (4, 0)
export var shift_move_force = Vector2 (10, 0)
var on_ground = false
var fast = false
var can_jump = false
var jump_time = 0.0
export var max_jump_time = 1.0
export var air_jumps = 0
var air_jumps_left = air_jumps
export var stick_walls = true

var jumping = false
var left = false
var right = false
var acceleration = false
var just_jumped = false

onready var health = $Health

func _enter_tree():
	GameManager.player = self

func _process(delta):
	var prev_jumping = jumping
	jumping = Input.is_action_pressed ("jump")
	just_jumped = jumping and not prev_jumping
	acceleration = Input.is_action_pressed ("acceleration")
	right = Input.is_action_pressed ("right")
	left = Input.is_action_pressed ("left")

func _physics_process(delta):
	move_and_collide(velocity)
	if test_move(get_transform(), Vector2 (0, -1)):
		velocity.y = 0
	if test_move(get_transform(), Vector2 (0, 1)):
		on_ground = true
	elif stick_walls and (
		test_move(get_transform(), Vector2(1, 0)) or 
		test_move(get_transform(), Vector2(-1, 0))) and not can_jump:
		on_ground = true
	else:
		if velocity.y > 0:
			velocity += strong_gravity_acceleration
		elif can_jump:
			velocity += jump_gravity_acceleration
		else:
			velocity += gravity_acceleration
		on_ground = false
	if on_ground:
		velocity = Vector2 (0, 0)
	if jumping:
		if just_jumped and (on_ground or air_jumps_left > 0):
			air_jumps_left -= 1
			if on_ground:
				air_jumps_left = air_jumps
			can_jump = true
			jump()
		if can_jump:
			jump_time += delta
		if jump_time > max_jump_time:
			can_jump = false
			jump_time = 0
	else:
		can_jump = false
	if acceleration:# and on_ground:
		fast = true
	else:
		fast = false
	if right:
		right ()
	elif left:
		left ()
	else:
		velocity.x = 0
	
	if not on_ground:
		pass # $AnimatedSprite.animation = "jump"
	elif right or left:
		if fast:
			pass # $AnimatedSprite.animation = "run"
		else:
			pass # $AnimatedSprite.animation = "run"
	else:
		pass # $AnimatedSprite.animation = "default"

func jump ():
	velocity.y = jump_force.y

func right ():
	if fast:
		move_and_slide (shift_move_force)
	else:
		move_and_slide (move_force)
	# $AnimatedSprite.flip_h = false

func left ():
	if fast:
		move_and_slide (-shift_move_force)
	else:
		move_and_slide (-move_force)
	# $AnimatedSprite.flip_h = true
