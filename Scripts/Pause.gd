extends Button

func pause():
	GameManager.pause()

func restart():
	resume()
	GameManager.game()

func menu():
	resume()
	GameManager.menu()

func resume():
	GameManager.unpause()

func _process(delta):
	$UI.visible = GameManager.paused()
