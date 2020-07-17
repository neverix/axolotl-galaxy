extends Node

var level_prefix = "res://Scenes/"
var level_suffix = ".tscn"
var levels = [
	"Test",
	"Test",
	"Menu"
]
var level = 0
var player = null
var next_player = null

func _process(delta):
	player = next_player

func player(new_player):
	next_player = new_player

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
