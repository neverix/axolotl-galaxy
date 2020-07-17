extends Node2D

export var speed = 10

func _process(delta):
	GameManager.player.health.damage(delta * speed)
