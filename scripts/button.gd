extends Button

const next = "res://levels/test.tscn"


func _pressed():
	get_tree().change_scene(next)
