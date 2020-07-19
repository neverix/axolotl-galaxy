extends Control

export var max_health = 5
var now_health = max_health
var bar

func _ready():
	bar = get_tree().get_nodes_in_group("Health")[0]
	bar.max_value = max_health
	bar.value = now_health

func health(new_value):
	now_health = new_value
	bar.value = new_value

func damage(damage_value):
	health(now_health - damage_value)
	if now_health <= 0:
		death()

func death():
	if get_parent() == GameManager.cur_player:
		GameManager.death()
