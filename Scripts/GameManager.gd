extends Node

var player = null
var level_prefix = "res://Scenes/"
var level_suffix = ".tscn"
var levels = [
	"Test",
	"Menu"
]
var level = 0

func level(index):
	return level_prefix + levels[index] + level_suffix

func death():
	game()

func game():
	load_scene(level(level))

func win():
	level += 1
	game()

func menu():
	load_scene("res://Scenes/Menu.tscn")

func load_scene(scene):
	get_tree().change_scene(scene)
