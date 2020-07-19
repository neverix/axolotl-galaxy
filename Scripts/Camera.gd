extends Camera2D

func _process(_delta):
	position.x = min(max(GameManager.cur_player.position.x, 450), 1360)
	position.y = min(max(GameManager.cur_player.position.y, 170), 710)
