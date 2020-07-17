extends Area2D

export var damage = 20

func _process(delta):
	if overlaps_body(GameManager.player):
		GameManager.player.health.damage(delta * damage)
