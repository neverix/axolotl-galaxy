extends Node

var player = null

func death():
	menu()

func game():
	load_scene("res://Levels/Test.tscn")

func menu():
	load_scene("res://Scenes/Menu.tscn")

func load_scene(scene):
	get_tree().change_scene(scene)
