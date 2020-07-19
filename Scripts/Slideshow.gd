extends Node2D

onready var img = $Image
export var textures = [
	preload("res://Location1/fone2.png"),
	preload("res://icon.png")
]
export var speed = 1
export var delay = 5
var index = 0

func _ready():
	show()

func show():
	if index >= len(textures):
		next()
		return
	img.texture = textures[index]
	Fader.fade_out(speed, funcref(self, "wait"))

func wait():
	get_tree().create_timer(delay).connect("timeout", self, "switch")

func switch():
	index += 1
	Fader.fade_in(speed, funcref(self, "show"))

func next():
	GameManager.game()
