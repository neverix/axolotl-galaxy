extends KinematicBody2D

# текущая скорость
var velocity = Vector2 (0, 0)
# обычное притяжение
export var gravity_acceleration = Vector2 (0, 1)
# притяжение при падении после прыжка. должно быть выше, чтобы лучше игралось
export var strong_gravity_acceleration = Vector2 (0, 1.2)
# сила прыжка
export var jump_force = Vector2 (0, -15)
# притяжение во время прыжка. должно быть ниже по тем же соображениям
# прыжок только добавиляет силу. так как мы не можем предсказать, сколько
# игрок будет удерживать прыжок, на всю продолжительность прыжка надо снизить гравитацию
export var jump_gravity_acceleration = Vector2 (0, 0.5)
# скорость перемещения
export var move_force = Vector2 (200, 0)
# скорость бега
export var shift_move_force = Vector2 (400, 0)

var on_ground = false
var fast = false
var rising = false
var jump_time = 0.0
export var max_jump_time = 2
export var air_jumps = 0
var air_jumps_left = air_jumps
export var stick_walls = false

var jumping = false
var left = false
var right = false
var acceleration = false
var just_jumped = false

onready var health = $Health
export var shift_distance = 150
export var first_player = true
export var flip_sprite = false



func _enter_tree():
	if first_player:
		GameManager.player(self)

func _ready():
	$AnimatedSprite.flip_h = flip_sprite

func control():
	if GameManager.cur_player == self:
		jumping = Input.is_action_pressed ("jump")
		acceleration = Input.is_action_pressed ("acceleration")
		right = Input.is_action_pressed ("right")
		left = Input.is_action_pressed ("left")
		if Input.is_action_just_pressed("shift"):
			# смотрим на все сущности и выбираем самую близкую, не равную
			# себе и в пределах shift_distance
			var players = get_tree().get_nodes_in_group("Player")
			var min_distance = INF
			var target = null
			for player in players:
				if player == self:
					continue
				var distance = position.distance_to(player.position)
				if distance < min_distance:
					min_distance = distance
					target = player
			if min_distance < shift_distance:
				shift(target)
	else:
		ai()

func ai():
	jumping = false
	acceleration = false
	right = false
	left = false

func shift(target):
	GameManager.player(target)

func _process(_delta):
	var prev_jumping = jumping
	control()
	just_jumped = jumping and not prev_jumping

func _physics_process(delta):
	# здесь мы берем управление и двигаем персонажа
	
	# двигаем его согласно текущей скорости
	move_and_collide(velocity)
	# проверяем, не прыгнул ли он до потолка
	if test_move(get_transform(), Vector2 (0, -1)):
		velocity.y = 0
	# проверяем, на земле ли персонаж
	if test_move(get_transform(), Vector2 (0, 1)):
		on_ground = true
	# проверяем, не сидит ли персонаж на стене. он так может делать только
	# тогда, когда он падает после прыжка - иначе он не сможет спрыгнуть со стены
	# и прыгать по ней. возможно эту логику надо поменять.
	elif stick_walls and (
		test_move(get_transform(), Vector2(1, 0)) or 
		test_move(get_transform(), Vector2(-1, 0))) and not rising:
		on_ground = true
	# игрок в воздухе. применяем подходящую силу притяжения
	else:
		on_ground = false
		if velocity.y > 0:
			velocity += strong_gravity_acceleration
		elif rising:
			velocity += jump_gravity_acceleration
		else:
			velocity += gravity_acceleration
	# если он на земле, обнуляем скорость. горизонтальную составляющую мы зададим ниже
	if on_ground:
		velocity = Vector2 (0, 0)
	# если нажата кнопка прыжок
	if jumping:
		# только что прыгнул, добавляем силу прыжка
		if just_jumped and (on_ground or air_jumps_left > 0):
			air_jumps_left -= 1
			if on_ground:
				air_jumps_left = air_jumps
			rising = true
			jump_time = 0
			jump()
		# все еще поднимается, добавляем время к прыжку
		if rising:
			jump_time += delta
		# падает, так как превышено максимальное время прыжка
		if jump_time > max_jump_time:
			rising = false
			jump_time = 0
	# если кнопка отпущена, он тоже падает
	else:
		rising = false
	# ну а дальше я думаю понятно
	if acceleration:# and on_ground:
		fast = true
	else:
		fast = false
	if right:
		right_motion()
	elif left:
		left_motion()
	else:
		velocity.x = 0
	
	if not on_ground:
		$AnimatedSprite.animation = "jump"
	elif right or left:
		$AnimatedSprite.animation = "run"
	else:
		$AnimatedSprite.animation = "default"
	$AnimatedSprite.play()
	


func jump():
	velocity.y = jump_force.y

func right_motion():
	if fast:
		move_and_slide (shift_move_force)
	else:
		move_and_slide (move_force)
	$AnimatedSprite.flip_h = false

func left_motion():
	if fast:
		move_and_slide (-shift_move_force)
	else:
		move_and_slide (-move_force)
	$AnimatedSprite.flip_h = true
