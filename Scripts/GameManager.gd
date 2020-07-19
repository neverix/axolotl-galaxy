extends Node

var level_prefix = "res://Scenes/"
var level_suffix = ".tscn"
var levels = [
	"L0S1_pos1", #0
	"L0S1_pos2", #1
	
	"L0S2_pos1", #2
	"L0S2_pos2", #3
	
	"L0S3_pos1", #4
	"L0S3_pos2", #5
	
	"L1S1_1pos", #6
	"L1S1_2pos", #7
	 
	"L1S2_1pos", #8
	"L1S2_2pos", #9
	"L1S2_3pos", #10
	
	"L1S3_1pos", #11
	"L1S3_2pos", #12
	
	"L2S1_1pos", #13
	"L2s1_2pos", #14
	
	"Menu" #15
]
var level_index = 0
var cur_player = null
var next_player = null

func pause():
	get_tree().paused = true

func unpause():
	get_tree().paused = false

func paused():
	return get_tree().paused

func _process(delta):
	cur_player = next_player

func player(new_player):
	next_player = new_player

func level(index):
	return level_prefix + levels[index] + level_suffix

func death():
	game()

func game():
	Music.switch(Music.levels[level_index])
	load_scene(level(level_index))

func win(next_level):
	level_index = next_level
	game()

func menu():
	load_scene("res://Scenes/Menu.tscn")
	Music.switch(2)

var scene_to_load = ""
var fade_speed = 5
var fading_in = true
onready var fader = Fader

func load_scene(scene):
	scene_to_load = scene
	Fader.fade_in(fade_speed, funcref(self, "scene_loaded"))

func scene_loaded():
	get_tree().change_scene(scene_to_load)
	Fader.fade_out(fade_speed, funcref(self, "nop"))

func nop():
	pass
