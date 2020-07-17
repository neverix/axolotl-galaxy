extends Control

export var max_health = 100
var health = max_health
var player = false
onready var bar = $ProgressBar

func _ready():
	bar.max_value = max_health
	bar.value = health
	if GameManager.player == get_parent():
		player = true

func health(new_value):
	health = new_value
	bar.value = new_value

func damage(damage_value):
	health(health - damage_value)
	if health < 0:
		death()

func death():
	if player:
		GameManager.death()
