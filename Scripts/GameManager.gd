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
	
	"L1S1_pos1", #6
	"L1S1_pos2", #7
	 
	"L1S2_pos1", #8
	"L1S2_pos2", #9
	"L1S2_pos3", #10
	
	"L1S3_pos1", #11
	"L1S3_pos2", #12
	
	"L2S1_pos1", #13
	"L2S1_pos2", #14
	
	"L2S2", # 15
	"L2S3", # 16
	
	"ComingSoon" #17
]
var level_index = 0
var skip_cutscene = false
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

func start():
	if skip_cutscene:
		game()
		return
	load_scene("res://Scenes/Slideshow.tscn")

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
