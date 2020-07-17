extends Area2D

func _process(delta):
	if overlaps_body(GameManager.player):
		GameManager.win()
