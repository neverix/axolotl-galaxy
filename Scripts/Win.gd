extends Area2D

export var next_level: int

func _process(_delta):
	if overlaps_body(GameManager.cur_player):
		GameManager.win(next_level)
