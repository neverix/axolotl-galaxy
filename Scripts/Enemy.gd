extends Area2D

export var damage = 1

func _process(delta):
	if overlaps_body(GameManager.cur_player):
		GameManager.cur_player.health.damage(delta * damage)
