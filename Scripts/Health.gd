extends Control

export var max_health = 5
var now_health = max_health
var player = false
onready var bar = $ProgressBar

func _ready():
	bar.max_value = max_health
	bar.value = now_health
	if GameManager.cur_player == get_parent():
		player = true

func health(new_value):
	now_health = new_value
	bar.value = new_value

func damage(damage_value):
	health(now_health - damage_value)
	if now_health <= 0:
		death()

func death():
	if player:
		GameManager.death()
