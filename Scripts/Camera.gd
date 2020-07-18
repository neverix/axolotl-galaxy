extends Camera2D

func _process(_delta):
	if (GameManager.cur_player.position.x > 450
	and GameManager.cur_player.position.x < 1360):
		position = Vector2(GameManager.cur_player.position.x, position.y)
	if (GameManager.cur_player.position.y < 710
	and GameManager.cur_player.position.y > 170):
		position = Vector2(position.x, GameManager.cur_player.position.y)
