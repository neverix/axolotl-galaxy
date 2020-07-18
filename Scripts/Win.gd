extends Area2D

func _process(_delta):
	if overlaps_body(GameManager.cur_player):
		GameManager.win(2)
