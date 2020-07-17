extends Node

var player = null
var level = "res://Levels/Test.tscn"

func death():
	game()

func game():
	load_scene(level)

func menu():
	load_scene("res://Scenes/Menu.tscn")

func load_scene(scene):
	get_tree().change_scene(scene)
